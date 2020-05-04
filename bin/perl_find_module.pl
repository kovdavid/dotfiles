#!/usr/bin/env perl

BEGIN { $ENV{NIKE_HOME} ||= "/usr/nikesoft" }

use v5.10;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use File::Basename;

my ($input_file, $line_number, $column, $type) = @ARGV;

# $input_file = "/usr/nikesoft/trading-platform/lib/Prematch/UFO/Fixtures.pm";
# $line_number = 54;
# $column = 30;
# $type = 5;

exit unless $input_file && $line_number;

open my $log_fh, ">", "/tmp/perl_find_module.log" or die "open log: $!";
say $log_fh join(" ", @ARGV);
close $log_fh;

if (($type // -1) == 5) {
	my $dir = $input_file;
	while ($dir ne '/') {
		$dir = dirname($dir);
		if ( -f "$dir.pm" ) {
			say "$dir.pm\t0";
		}
	}
	exit;
}

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

	my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/ | xargs grep -n -m 1 -H '^sub $function'";
	my @res = `$cmd`;

	if (scalar(@res)) {
		my ($file, $line, undef) = split(":", $res[0]);
		say "$file\t$line";
	}
} elsif ($line =~ m#((?:(?:[A-Z][A-Za-z_]*(?:::)?)+))#) {
	# Napr Prematch::Request::ManualManageKS::DeleteBet

	my @tokens = split("::", $1);

	# Prematch::Request::ManualManageKS::DeleteBet

	my $file = "lib/".join("/", @tokens).".pm";
	my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/";
	my @res = `$cmd`;

	if (scalar(@res)) {
		my $file = $res[0];
		chomp $file;
		say "$file\t0";
	} else {
		# Prematch::Request::ManualManageKS::DeleteBet - DeleteBet je asi nejaka konstanta

		my $const = pop @tokens;

		my $file = "lib/".join("/", @tokens).".pm";
		my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/ | xargs grep -n -m 1 -H '$const'";
		my @res = `$cmd`;

		if (scalar(@res)) {
			my ($file, $line, undef) = split(":", $res[0]);
			say "$file\t$line";
		}
	}
}
