#/usr/bin/perl

# Hacky solution to coloring folders based on last opened date
# Todo;
# - Integrate osascript

use File::Find;
use strict;
use warnings;

my $top_dir = "/Volumes/hydrogen/FLAC/";
my %data = ();

sub wanted {
    if ($File::Find::name) {
        my $curr_file_path = quotemeta($File::Find::name);
        my $mdls_data = `mdls $curr_file_path`;
        $mdls_data =~ m/kMDItemLastUsedDate\s+=\s+(\d+\S+\s)(\d+\S+\s)/g;
        $data {$curr_file_path} = $1;
    }
}

find(\&wanted, $top_dir);

# We now have the last accessed dates(values) and file(keys) paths stored as a hash
# We now want to itterate though the hash and change the last accessed
# data to an index we can pass to osascript to set as a folder color

while ((my $k, my $v) = each %data) {
    print "$k => $v\n";
}
