#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use JSON::XS qw[ encode_json decode_json ];
use IO::Handle;

$| = 1;

# click event
# {"name":"i3_alarm","button":1,"x":1131,"y":1070}

open my $fh, '-|', 'i3status -c ~/.i3/i3status' or die "Could not start i3status: $!";
while (my $line = <$fh>) {
	if (substr($line, 0, 1) ne ",") {
		if (index($line, 'version') > 0) {
			say '{"version":1,"click_events":true}';
		} else {
			say $line;
		}
		next;
	}
	my $json = substr($line, 1);
	my $data = decode_json($json);

	my $i3_split_orientation = get_i3_split_orientation();
	my $todo_count = get_todo_count();

	unshift @{ $data }, {
		full_text => "i3Split: $i3_split_orientation",
	};
	unshift @{ $data }, {
		full_text => "TODO: $todo_count",
	};

	unshift @{ $data }, get_i3_alarm();

	say ",".encode_json($data);
}

sub get_i3_alarm {
	open my $fh, "<", "/tmp/.i3_alarm" or return ();
	my @lines = <$fh>;
	close $fh;

	my $now = time();

	my @result;
	my $line_number = 0;
	for my $line (@lines) {
		$line_number++;

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
	}

	return @result;
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
	open my $fh, "<", "~/TODO/TODO" or return "0";
	my @lines = <$fh>;
	close $fh;

	return scalar(@lines);
}
