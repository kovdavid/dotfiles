#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

my $args = shift || '';

use constant {
    DISABLE_FILE => "/tmp/redshift_disable",
};

if ($args eq '-t') {
    if ( -f DISABLE_FILE ) {
        unlink DISABLE_FILE;
    } else {
        open my $fh, ">", DISABLE_FILE;
        say $fh "";
        close $fh;

        exit system("redshift -x");
    }
}

if ( -f DISABLE_FILE ) {
    my $now = time();
    my $mtime = (stat(DISABLE_FILE))[9];
    my $file_age = abs($now - $mtime);
    if ($file_age <= 3*3600) {
        exit;
    }
}

use POSIX qw( strftime );

my $STEPS = 5; # minutes

my $raw_config_by_month = [
    {
        months => [ 1, 2, 3, 10, 11, 12 ],
        config => {
            #hour + minute
             0*60 + 00 => { temp => 1300, brightness => '0.70' },
             6*60 + 30 => { temp => 1300, brightness => '0.70' },
             7*60 + 30 => { temp => 2400, brightness => '0.85' },
             8*60 + 00 => { temp => 2800, brightness => '0.90' },
             9*60 + 00 => { temp => 4700, brightness => '1.00' },
            16*60 + 00 => { temp => 4700, brightness => '1.00' },
            21*60 + 00 => { temp => 1300, brightness => '0.70' },
        },
    },
    {
        months => [ 4, 5, 6, 7, 8, 9 ],
        config => {
            #hour + minute
             0*60 + 00 => { temp => 1300, brightness => '0.70' },
             6*60 + 30 => { temp => 1300, brightness => '0.70' },
             7*60 + 30 => { temp => 2800, brightness => '0.70' },
             8*60 + 00 => { temp => 4700, brightness => '1.00' },
            18*60 + 00 => { temp => 4700, brightness => '1.00' },
            21*60 + 00 => { temp => 1300, brightness => '0.70' },
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
