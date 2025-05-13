#!/usr/bin/env perl
use strict;
use warnings;

my $coords_file = shift or die "Usage: $0 <show-coords.txt>\n";

open my $fh, '<', $coords_file or die "Could not open $coords_file: $!";

<$fh>;
<$fh>;
<$fh>;
<$fh>;
while (<$fh>) {
    chomp;
    my @fields = split/\t/;
    
    # set values from field
    my ($sstart, $send, $qstart, $qend, $len1, $len2, 
        $pident, $slen, $qlen, $sseqid, $qseqid ) = @fields;

    # set candicate alignment length and mismatch
    my $alnlen = $len1;
    my $mismatch = int(0.5 + (( 100 - $pident ) * $len1 )/100 );
    # gapopen evalue, bitscore
    my $gapopen = -1;
    my $evalue = -1;
    my $bitscore = -1;
    print join("\t",
               $qseqid, $sseqid, sprintf("%.2f", $pident),
               $alnlen, $mismatch, $gapopen,
               $qstart, $qend, $sstart, $send,
               $evalue, $bitscore,
               $qlen, $slen
        ), "\n";
}

close $fh;
