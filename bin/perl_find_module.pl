#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use Carp;
use Data::Dumper;

my ($input_file, $line_number, $column) = @ARGV;

exit unless $input_file && $line_number;

open my $fh, "<", $input_file or die "open $input_file: $!";
my @lines = <$fh>;
close $fh;

my $line = $lines[$line_number-1];

chomp $line;

exit unless $line;

if ($line =~ m#((?:(?:[A-Z][A-Za-z]*::)+)\w+)\(#) {
	# Napr Prematch::Request::ManualManageKS::DeleteBet::collect_changes(

	my @tokens = split("::", $1);

	my $function = pop @tokens;

	my $file = join("/", @tokens).".pm";

	my $cmd = "find $ENV{NIKE_HOME} -wholename '*$file' | xargs grep -n -m 1 -H '^sub $function'";
	my @res = `$cmd`;

	if (scalar(@res)) {
		my ($file, $line, undef) = split(":", $res[0]);
		say "$file\t$line";
	}
} elsif ($line =~ m#((?:(?:[A-Z][A-Za-z]*(?:::)?)+))#) {
	# Napr Prematch::Request::ManualManageKS::DeleteBet

	my $file = "lib/".join("/", split("::", $1)).".pm";
	my $cmd = "find /usr/nikesoft/ -wholename '*$file'";
	my @res = `$cmd`;

	if (scalar(@res)) {
		my $file = $res[0];
		chomp $file;
		say "$file\t0";
	}
}
