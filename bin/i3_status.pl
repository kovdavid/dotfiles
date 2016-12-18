#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use utf8;

use JSON::XS qw[ encode_json decode_json ];
use IO::Poll qw[ POLLIN POLLHUP POLLERR ];
use IO::Handle;

$| = 1;
open my $i3status_fh, '-|', 'i3status -c ~/.i3/i3status'
    or die "Could not start i3status: $!";

STDIN->blocking(0);

open STDERR, ">>", "/tmp/i3_status_stderr";

my $poll = IO::Poll->new();
$poll->mask(\*STDIN => POLLIN | POLLHUP | POLLERR);
$poll->mask($i3status_fh => POLLIN | POLLHUP | POLLERR);

while (1) {
    $poll->poll(1);
    for my $handle ($poll->handles()) {
        my $events = $poll->events($handle);
        next unless $events;

        if (($events & POLLHUP) or ($events & POLLERR)) {
            die "Received $events, exiting";
        }

        if ($events & POLLIN) {
            my $buffer;
            my $length = sysread($handle, $buffer, 65535);
            if (not $length) {
                die "sysread error";
            }

            next unless $buffer;
            next if $buffer =~ m#^\s*$#;

            if ($handle == $i3status_fh) {
                handle_i3status_message($buffer);
            } else {
                handle_click($buffer);
            }
        }
    }
}

sub handle_click {
    my ($buffer) = @_;

    my $first_char = substr($buffer, 0, 1);
    if ($first_char eq '[' or $first_char eq ',') {
        $buffer = substr($buffer, 1);
    }

    return unless $buffer;
    return if $buffer =~ m#^\s*$#;

    my $data;
    eval { $data = decode_json($buffer) };
    if ($@) {
        die "handle_click: Could not decode json [$buffer] because: $@";
    }

    my $name = $data->{name};
    my $instance = $data->{instance};
    my $button = $data->{button};

    open my $fh, "<", "/tmp/.i3_alarm" or return;
    my @alarms = map { chomp $_; $_ } <$fh>;
    close $fh;

    if ($button == 2) {
        # Middle click - remove event
        splice @alarms, $instance, 1;
    } elsif ($button == 1 or $button == 3) {
        # Left or Right click - snooze 5 min
        my (undef, $message) = split("\t", $alarms[$instance], 2);
        my $time = time() + 300;
        $alarms[$instance] = "$time\t$message";
    } elsif ($button == 4) {
        # Scroll up - +1 min
        my ($time, $message) = split("\t", $alarms[$instance], 2);
        if ($time < time()) {
            $time = time() + 60;
        } else {
            $time = $time + 60;
        }
        $alarms[$instance] = "$time\t$message";
    } elsif ($button == 5) {
        # Scroll down - -1 min
        my ($time, $message) = split("\t", $alarms[$instance], 2);
        if ($time > time()) {
            $time = $time > 60 ? ($time - 60) : 0;
        }
        $alarms[$instance] = "$time\t$message";
    }

    my $result_content = join("\n", @alarms);

    open my $fh_out, ">", "/tmp/.i3_alarm" or return;
    print $fh_out $result_content;
    close $fh_out;

    `killall -USR1 i3status`;
}

sub handle_i3status_message {
    my ($buffer) = @_;

    if (substr($buffer, 0, 1) eq '{' and index($buffer, '{"version":1') == 0) {
        print qq#{"version":1,"click_events":true}\n[\n#;
        return;
    }

    my $prefix = '';
    if (substr($buffer, 0, 1) eq ',') {
        $prefix = ',';
        $buffer = substr($buffer, 1);
    }

    return unless $buffer;
    return if $buffer =~ m#^\s*$#;

    my $data;
    eval { $data = decode_json($buffer) };
    if ($@) {
        die "handle_i3status_message: Could not decode json [$buffer] because: $@";
    }

    my $i3_split_orientation = get_i3_split_orientation();
    my $todo_count = get_todo_count();

    unshift @{ $data }, { full_text => "$i3_split_orientation" };
    unshift @{ $data }, { full_text => "TODO: $todo_count" };
    unshift @{ $data }, get_i3_alarms();

    my $output = $prefix . encode_json($data);

    say $output;
}

sub get_i3_split_orientation {
    open my $fh, "<", "/tmp/.i3_split_orientation" or return "—";
    my $content = <$fh>;
    chomp $content;
    close $fh;

    if ($content and $content eq 'horizontal') {
        return "I";
    } else {
        return "—";
    }
}

sub get_todo_count {
    open my $fh, "<", "/home/davs/TODO/TODO" or return "$!";
    my @lines = <$fh>;
    close $fh;

    return scalar(@lines);
}

sub get_i3_alarms {
    open my $fh, "<", "/tmp/.i3_alarm" or return ();
    my @lines = <$fh>;
    close $fh;

    my $now = time();

    my @result;
    my $line_number = 0;
    for my $line (@lines) {
        my ($timestamp, $message) = split("\t", $line);
        chomp $message;

        my $remaining = $timestamp - $now;
        if ($remaining < 5) {
            $remaining = $remaining < 0 ? 0 : $remaining;
            push @result, {
                full_text => "$remaining - $message",
                color => "#ff0000",
                name => "i3_alarm",
                instance => "$line_number",
            };
        } elsif ($remaining < 60) {
            push @result, {
                full_text => "$remaining - $message",
                color => "#00ff00",
                name => "i3_alarm",
                instance => "$line_number",
            };
        } else {
            push @result, {
                full_text => "$remaining - $message",
                name => "i3_alarm",
                instance => "$line_number",
            };
        }
        $line_number++;
    }

    return @result;
}
