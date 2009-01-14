#!/usr/bin/perl

use File::Basename;

$utildirname = dirname($0);
$platformscript = "$utildirname/platform.pl";

my $flag = $ARGV[0];

if ($flag eq "" || $flag eq "--host") {
    $preset_compiler=$ENV{'CHPL_HOST_COMPILER'};
} elsif ($flag eq "--target") {
    $preset_compiler=$ENV{'CHPL_TARGET_COMPILER'};
}

if ($preset_compiler eq "") {
    $platform = `$platformscript $flag`;
    chomp($platform);
    if ($platform eq "mta" || $platform eq "xmt" || $platform eq "xmt-sim") {
	$compiler = "cray-mta";
    } elsif ($platform eq "x1"     || $platform eq "x2" ||
             $platform eq "x1-sim" || $platform eq "x2-sim") {
	$compiler = "cray-vec";
    } elsif ($platform eq "xt-cle") {
        if ($flag eq "--host") {
            $compiler = "gnu";
        } else {
            $subcompiler = "-$ENV{'PE_ENV'}";
            if ($subcompiler eq "-") {
                $subcompiler = "";
            } else {
                $subcompiler =~ tr/A-Z/a-z/;
            }
            $compiler = "cray-xt$subcompiler";
        }
    } else {
	if (`$platformscript --host` eq `$platformscript --target`) {
	    $compiler=$ENV{'CHPL_HOST_COMPILER'};
	}
	if ($compiler eq "") {
	    $compiler = "gnu";
	}
    }
} else {
    $compiler = $preset_compiler;
}


print "$compiler\n";
exit(0);
