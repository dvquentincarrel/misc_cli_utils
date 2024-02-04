#!/bin/perl
# Shortens path
for($ARGV[0]) {
    if (/-(h|-help)/) {
        print "Usage: shorten_path PATH [SIZE]\n";
        print "Shortens dir names in PATH to at most SIZE chars (1 by default)\n";
        exit
    }
}
$path = $ARGV[0];
$size = $ARGV[1] // 1; # Length of each path component
$path =~ s/$ENV{HOME}/~/;
$path =~ s!([^/~]{$size})[^/]*?/!\1/!g;
print "$path\n";
