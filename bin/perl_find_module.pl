#!/usr/bin/env perl

BEGIN { $ENV{NIKE_HOME} ||= "/usr/nikesoft" }

use v5.10;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use File::Basename;

my ($input_file, $line_number, $column, $type) = @ARGV;

my $DEBUG = 0;

# $input_file = "/usr/nikesoft/trading-platform/lib/Prematch/UFO/Fixtures.pm";
# $line_number = 54;
# $column = 30;
# $type = 5;

exit unless $input_file && $line_number;

my_log(join(" ", "REQUEST", @ARGV));
my $response = get_response();
my_log(join(" ", "RESPONSE", $response));

if ($response) {
	say $response;
}

sub get_response {
	if (($type // -1) == 5) {
		my $dir = $input_file;
		while ($dir ne '/') {
			$dir = dirname($dir);
			if ( -f "$dir.pm" ) {
				return "$dir.pm\t0";
			}
		}
		return;
	}

	open my $fh, "<", $input_file or die "open $input_file: $!";
	my @lines = <$fh>;
	close $fh;

	chomp $_ for @lines;

	my $aliases = get_file_aliases(\@lines);

	my $line = $lines[$line_number-1];

	return unless $line;

	my_log("line $line");

	return
		undef
		// check_type1($line)
		// check_type2($line)
		// check_type3($line, $aliases)
		// check_type4($line, $aliases)
		// "";
}

# Prematch::Request::ManualManageKS::DeleteBet::collect_changes(
sub check_type1 {
	my ($line) = @_;

	while ($line =~ m#((?:(?:[A-Z][A-Za-z]*::)+)\w+)\(#g) {
		my @tokens = split("::", $1);

		my $function = pop @tokens;

		my $file = join("/", @tokens).".pm";

		my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/ | xargs grep -n -m 1 -H '^sub $function'";
		my @res = `$cmd`;

		if (scalar(@res)) {
			my ($file, $line, undef) = split(":", $res[0]);
			return "$file\t$line";
		}
	}

	return;
}

# Prematch::Request::ManualManageKS::DeleteBet
sub check_type2 {
	my ($line) = @_;

	while ($line =~ m#((?:(?:[A-Z][A-Za-z0-9_]*(?:::)?)+))#g) {
		my @tokens = split("::", $1);

		# Prematch::Request::ManualManageKS::DeleteBet

		my $file = "lib/".join("/", @tokens).".pm";
		my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/";
		my @res = `$cmd`;

		if (scalar(@res)) {
			my $file = $res[0];
			chomp $file;
			return "$file\t0";
		}
	}

	return;
}

# TCH_Kurzlist::ipars_to_bet_params(
sub check_type3 {
	my ($line, $aliases) = @_;

	while ($line =~ m#((?:[A-Z][A-Za-z]*::)\w+)\(#g) {
		my @tokens = split("::", $1);
		next unless scalar(@tokens) == 2;

		my ($alias, $function) = @tokens;

		my $module = $aliases->{$alias};
		next unless $module;

		my $file = "lib/".join("/", split("::", $module)).".pm";
		my $cmd = "fd -c never -p '$file' $ENV{NIKE_HOME}/ | xargs grep -n -m 1 -H '^sub $function'";
		my @res = `$cmd`;

		if (scalar(@res)) {
			my ($file, $line, undef) = split(":", $res[0]);
			return "$file\t$line";
		}
	}

	return;
}

# TCH_Kurzlist::STAV
sub check_type4 {
	my ($line, $aliases) = @_;

	#TODO

	return;
}

sub get_file_aliases {
	my ($lines) = @_;

	my $result = {};
	my $found_tpd_alias = 0;

	for my $line (@{ $lines }) {
		if (not $found_tpd_alias and $line =~ /^use TPDAlias/) {
			$found_tpd_alias = 1;
		}

		if ($found_tpd_alias and $line =~ /^\s*$/) {
			return $result;
		}

		$line =~ s/^use TPDAlias//;

		if ($found_tpd_alias) {
			if ($line =~ m#^\s*(\S*)\s*=>\s*('|")([^'"]+)('|")#) {
				my $alias = $1;
				my $module = $3;
				$result->{$alias} = $module;
			}
		}
	}

	return $result;
}

sub my_log {
	my ($msg) = @_;

	open my $log_fh, ">>", "/tmp/perl_find_module.log" or die "open log: $!";
	say $log_fh $msg;
	# say $msg;
	close $log_fh;
}
