#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

use POSIX qw( strftime );
use File::Basename qw( basename );
use JSON::XS qw( encode_json decode_json );

my $script_name = basename($0, '.pl');

my $current_file = "/tmp/redshift_values.json";
my $output_file = "/tmp/$script_name";

use constant {
    MAX_BRIGHTNESS => 1.0,
    MAX_TEMP => 6500,
};

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
             6*60 + 30 => { temp => 1300, brightness => '0.70' },
             7*60 + 30 => { temp => 2800, brightness => '0.70' },
             8*60 + 00 => { temp => 6500, brightness => '1.00' },
            18*60 + 00 => { temp => 6500, brightness => '1.00' },
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

my $new_values = get_new_values($config->{$key});
my $current_values = get_current_values($current_file);

my $temp_diff = $new_values->{temp} - $current_values->{temp};
my $brightness_diff = sprintf("%.2f", $new_values->{brightness} - $current_values->{brightness});

open my $fh, ">", $output_file or die $!;
print $fh "$temp_diff $brightness_diff";
close $fh;

system('killall -USR1 i3status');

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

sub get_current_values {
    my ($file) = @_;

    unless ( -f $file ) {
        open my $fh, ">", $file or die "Could not open file:$file for writing $!";
        print $fh encode_json({ temp => MAX_TEMP, brightness => MAX_BRIGHTNESS });
        close $fh;
    }

    open my $fh, "<", $file or die "Could not open file:$file for reading: $!";
    my $json = <$fh>;
    close $fh;

    my $data = decode_json($json);
    return $data;
}

sub get_new_values {
    my ($args) = @_;

    my $brightness = sprintf("%.2f", $args->{brightness});
    my $temp = int($args->{temp});

    if ($brightness > MAX_BRIGHTNESS) {
        $brightness = MAX_BRIGHTNESS;
    }
    if ($temp > MAX_TEMP) {
        $temp = MAX_TEMP;
    }

    return {
        temp => $temp,
        brightness => $brightness,
    };
}
