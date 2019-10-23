#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use POSIX qw[ strftime ];

if (@ARGV) {
    `redshift -x`;
    exit;
}

my $now = time();
my $hour = strftime("%H", localtime($now));
my $minute = strftime("%M", localtime($now));

my $config = {
    0  => { 0 => "-O 1300 -b 0.7" },
    1  => { 0 => "-O 1300 -b 0.7" },
    2  => { 0 => "-O 1300 -b 0.7" },
    3  => { 0 => "-O 1300 -b 0.7" },
    4  => { 0 => "-O 1300 -b 0.7" },
    5  => { 0 => "-O 1300 -b 0.7" },
    6  => { 0 => "-O 1300 -b 0.7" },
    7  => { 0 => "-O 1300 -b 0.8" },
    8  => { 0 => "-O 2800 -b 0.8" },
    9  => { 0 => "-O 4700 -b 1.0" },
    10 => { 0 => "-O 4700 -b 1.0" },
    11 => { 0 => "-O 4700 -b 1.0" },
    12 => { 0 => "-O 4700 -b 1.0" },
    13 => { 0 => "-O 4700 -b 1.0" },
    14 => { 0 => "-O 4700 -b 1.0" },
    15 => { 0 => "-O 4700 -b 1.0" },
    16 => { 0 => "-O 4700 -b 1.0" },
    17 => { 0 => "-O 2700 -b 0.8" },
    18 => { 0 => "-O 2200 -b 0.8" },
    19 => { 0 => "-O 2200 -b 0.8" },
    20 => { 0 => "-O 2200 -b 0.7" },
    21 => { 0 => "-O 1300 -b 0.7" },
    22 => { 0 => "-O 1300 -b 0.7" },
    23 => { 0 => "-O 1300 -b 0.7" },
    24 => { 0 => "-O 1300 -b 0.7" },
};

my $last_hour_key = 0;
for my $hour_key (sort { $a <=> $b } keys %{ $config }) {
    if ($hour_key > $hour) {
        last;
    }
    $last_hour_key = $hour_key;
}
my $last_minute_key = 0;
for my $minute_key (sort { $a <=> $b } keys %{ $config->{ $last_hour_key } }) {
    if ($minute_key > $minute) {
        last;
    }
    $last_minute_key = $minute_key;
}

my $args = $config->{ $last_hour_key }->{ $last_minute_key };

`redshift -P $args`;
