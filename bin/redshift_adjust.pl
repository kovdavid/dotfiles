#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use POSIX qw( strftime );
use JSON qw( encode_json decode_json );

my $args = shift || '';

use constant {
    DISABLE_FILE    => "/tmp/redshift_disable",
    LOG_FILE        => "/tmp/redshift_adjust.log",
    CORRECTION_FILE => "/tmp/redshift_correction.cfg",

    MIN_BRIGHTNESS => 0.2,
    MAX_BRIGHTNESS => 1.0,
    MIN_TEMP => 1000,
    MAX_TEMP => 6500,
};

open my $log, ">>", LOG_FILE;

handle_args($args);
my ($correction_temp, $correction_brightness) = get_corrections();

my $STEPS = 5; # minutes

my $raw_config_by_month = [
    {
        months => [ 1, 2, 3, 10, 11, 12 ],
        config => {
            #hour + minute
             0*60 + 00 => { temp => 1300, brightness => '0.70' },
             6*60 + 30 => { temp => 1300, brightness => '0.70' },
             7*60 + 30 => { temp => 2400, brightness => '0.85' },
             8*60 + 00 => { temp => 4000, brightness => '0.90' },
             9*60 + 00 => { temp => 6500, brightness => '1.00' },
            16*60 + 00 => { temp => 6500, brightness => '1.00' },
            21*60 + 00 => { temp => 1300, brightness => '0.70' },
        },
    },
    {
        months => [ 4, 5, 6, 7, 8, 9 ],
        config => {
            #hour + minute
             0*60 + 00 => { temp => 1300, brightness => '0.70' },
             6*60 + 30 => { temp => 3200, brightness => '0.80' },
             7*60 + 30 => { temp => 4200, brightness => '0.90' },
             8*60 + 00 => { temp => 6500, brightness => '1.00' },
            19*60 + 30 => { temp => 6500, brightness => '1.00' },
            21*60 + 00 => { temp => 4200, brightness => '1.00' },
            23*60 + 00 => { temp => 1300, brightness => '0.70' },
        },
    },
];

my $config;
my $month = int(strftime("%m", localtime(time)));
for my $raw_config (@{ $raw_config_by_month }) {
    if (grep { $_ == $month } @{ $raw_config->{months} }) {
        $config = normalize_config($raw_config->{config});
        last;
    }
}

unless ($config) {
    die "No config found for month $month";
}

my $now = time();
my $hour = strftime("%H", localtime($now));
my $minute = strftime("%M", localtime($now));

my $key = get_config_key($hour, $minute);
my $cmd = get_cmd($config->{$key}, $correction_brightness, $correction_temp);

if ($args eq "--dry-run") {
    say "$cmd";
    exit;
}

if (@ARGV) {
    print_config($config);
    say "key: $key";
    say "cmd: $cmd";
    exit;
}

print_log($cmd);

exit system($cmd);

sub normalize_config {
    my ($config) = @_;

    $config->{ 23*60 + 55 } = $config->{0};

    my ($prev_setting, $prev_minute);
    for my $minute (sort { $a <=> $b } keys %{ $config }) {
        my $setting = $config->{$minute};

        unless (defined($prev_minute)) {
            $prev_setting = $setting;
            $prev_minute = $minute;
            next;
        }

        my $minute_steps = int( ($minute - $prev_minute)/$STEPS )-1;

        my $prev_brightness = $prev_setting->{brightness};
        my $prev_temp = $prev_setting->{temp};

        my $temp_diff       = $setting->{temp}       - $prev_temp;
        my $brightness_diff = $setting->{brightness} - $prev_brightness;

        for my $min_step (1..$minute_steps) {
            my $fill_minute = $prev_minute+($min_step * $STEPS);

            my $brightness_increment = $min_step*( $brightness_diff/($minute_steps+1) );
            my $temp_increment = $min_step*( $temp_diff/($minute_steps+1) );

            $config->{$fill_minute}->{brightness} = $prev_brightness + $brightness_increment;
            $config->{$fill_minute}->{temp} = $prev_temp + $temp_increment;
        }

        $prev_setting = $setting;
        $prev_minute = $minute;
    }

    return $config;
}

sub get_config_key {
    my ($hour, $minute) = @_;

    $minute++ while ($minute % $STEPS);

    return $hour*60 + $minute;
}

sub get_cmd {
    my ($args, $correction_brightness, $correction_temp) = @_;

    my $brightness = sprintf("%.2f", $args->{brightness} + $correction_brightness);
    my $temp = int($args->{temp} + $correction_temp);

    if ($brightness < MIN_BRIGHTNESS) {
        $brightness = MIN_BRIGHTNESS;
    }
    if ($brightness > MAX_BRIGHTNESS) {
        $brightness = MAX_BRIGHTNESS;
    }
    if ($temp < MIN_TEMP) {
        $temp = MIN_TEMP;
    }
    if ($temp > MAX_TEMP) {
        $temp = MAX_TEMP;
    }

    return "redshift -P -m randr -O $temp -b $brightness";
}

sub print_config {
    my ($config) = @_;

    for my $minute (sort { $a <=> $b } keys %{ $config }) {
        say sprintf("minute:% 5d temp:%d brightness:%.2f", $minute, @{ $config->{$minute} }{qw( temp brightness )});
    }
}

sub print_log {
    my ($msg) = @_;

    my $date = strftime("%F %T", localtime());

    say $log "$date $msg";
    say $msg;
}

sub handle_args {
    my ($args) = @_;

    if ($args eq '-d') {
        if ( -f DISABLE_FILE ) {
            unlink DISABLE_FILE;
            print_log("unlink ${\DISABLE_FILE}");
        } else {
            open my $fh, ">", DISABLE_FILE;
            say $fh "";
            close $fh;

            print_log("touch ${\DISABLE_FILE}");
        }

        exit system("redshift -x");
    }

    if ( -f DISABLE_FILE ) {
        my $file_age = get_file_age(DISABLE_FILE);

        print_log("${\DISABLE_FILE} exists age:$file_age");

        if ($file_age <= 3*3600) {
            print_log("exit, because ${\DISABLE_FILE} is only $file_age sec old");
            exit;
        }
    }

    if ($args eq '--brightness-correction-up') {
        my ($correction_temp, $correction_brightness) = get_corrections();
        save_corrections($correction_temp, $correction_brightness + 0.05);
    } elsif ($args eq '--brightness-correction-down') {
        my ($correction_temp, $correction_brightness) = get_corrections();
        save_corrections($correction_temp, $correction_brightness - 0.05);
    } elsif ($args eq '--temp-correction-up') {
        my ($correction_temp, $correction_brightness) = get_corrections();
        save_corrections($correction_temp + 100, $correction_brightness);
    } elsif ($args eq '--temp-correction-down') {
        my ($correction_temp, $correction_brightness) = get_corrections();
        save_corrections($correction_temp - 100, $correction_brightness);
    }
}

sub save_corrections {
    my ($temp, $brightness) = @_;

    print_log("Setting corrections temp:$temp brightness:$brightness");

    my $json = JSON->new->canonical->encode({ temp => $temp, brightness => $brightness });
    open my $fh, ">", CORRECTION_FILE or die "Could not open ${\CORRECTION_FILE}: $!";
    say $fh $json;
    close $fh;
}

sub get_file_age {
    my ($file) = @_;

    my $now = time();
    my $mtime = (stat($file))[9];
    my $file_age = abs($now - $mtime);

    return $file_age;
}

sub get_corrections {
    if (-f CORRECTION_FILE) {
        my $file_age = get_file_age(CORRECTION_FILE);

        if ($file_age > 3*3600) {
            print_log("ignoring ${\CORRECTION_FILE}, because it is too old");
            return (0, 0);
        }

        open my $fh, "<", CORRECTION_FILE or die "Could not open ${\CORRECTION_FILE}: $!";
        my $json = do { local $/ = undef; <$fh> };
        close $fh;

        my $corrections = decode_json($json);

        if (defined $corrections->{temp} and defined $corrections->{brightness}) {
            print_log("Using corrections temp:$corrections->{temp} brightness:$corrections->{brightness}");
            return ($corrections->{temp}, $corrections->{brightness});
        }
    }

    return (0, 0);
}
