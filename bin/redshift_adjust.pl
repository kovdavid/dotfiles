#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use POSIX qw( strftime );

my $STEPS = 5; # minutes

my $config = normalize_config({
    #hour + minute
     0*60 + 00 => { temp => 1300, brightness => '0.70' },
     6*60 + 30 => { temp => 1300, brightness => '0.70' },
     7*60 + 30 => { temp => 1600, brightness => '0.70' },
     8*60 + 00 => { temp => 2800, brightness => '0.80' },
     9*60 + 00 => { temp => 4700, brightness => '1.00' },
    16*60 + 00 => { temp => 4700, brightness => '1.00' },
    21*60 + 00 => { temp => 1300, brightness => '0.70' },
});

my $now = time();
my $hour = strftime("%H", localtime($now));
my $minute = strftime("%M", localtime($now));

my $key = get_config_key($hour, $minute);
my $cmd = get_cmd($config->{$key});

if (@ARGV) {
    print_config($config);
    say "key: $key";
    say "cmd: $cmd";
    exit;
}

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
    my ($args) = @_;

    my $brightness = sprintf("%.2f", $args->{brightness});
    my $temp = int($args->{temp});

    return "redshift -P -m randr -O $temp -b $brightness";
}

sub print_config {
    my ($config) = @_;

    for my $minute (sort { $a <=> $b } keys %{ $config }) {
        say sprintf("minute:% 5d temp:%d brightness:%.2f", $minute, @{ $config->{$minute} }{qw( temp brightness )});
    }
}
