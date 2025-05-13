#!/usr/bin/env perl
use strict;
use warnings;

my $paf_file = shift or die "Usage: $0 <input.paf>\n";

open my $fh, '<', $paf_file or die "Could not open $paf_file: $!";

while (<$fh>) {
    chomp;
    my @fields = split/\t/;
    
    # set values from field
    my ($qseqid, $qlen, $qstart, $qend, $strand,
        $sseqid, $slen, $sstart, $send,
        $matches, $alnlen ) = @fields[0..10];

    # obtain CIGAR
    my $cigar = '';
    for my $f (@fields[12..$#fields]) {
        if ($f =~ /^cg:Z:(.+)$/) {
            $cigar = $1;
            last;
        }
    }
    my ( $alignment_match, $gapopen ) = calculate_gapopen($cigar);

    # calculate identity
    my $pident = ($alignment_match > 0) ? ($matches / $alignment_match) * 100 : 0;

    # mismatch = alnlen - matches
    my $mismatch = $alignment_match - $matches;

    # correct start/end positions (0-origin to 1-origin)
    my ($qs, $qe) = ($qstart+1, $qend);
    my ($ss, $se) = ($sstart+1, $send);
    if ($strand eq '-') {
        ($ss, $se) = ($se, $ss);
    }

    # evalue, bitscore
    my $evalue = -1;
    my $bitscore = -1;

    print join("\t",
        $qseqid, $sseqid, sprintf("%.2f", $pident),
        $alnlen, $mismatch, $gapopen,
        $qs, $qe, $ss, $se,
        $evalue, $bitscore,
        $qlen, $slen
        ), "\n";
}

close $fh;

sub calculate_gapopen {
    my ($cigar) = @_;
    return 0 unless $cigar;
    my $gapopen = 0;
    my $alignment_match = 0;
    my $prev = '';
    while ($cigar =~ /(\d+)([MIDNSHP=X])/g) {
        my ($len, $op) = ($1, $2);
        # sum up gapopen
        if (($op eq 'I' || $op eq 'D') && $prev ne $op) {
            $gapopen++;
        }
        # sum up alignment match
        if( $op eq 'M' ) {
            $alignment_match += $len;
        }        
        $prev = $op;
    }
    $alignment_match += $gapopen;
    return ( $alignment_match, $gapopen );
}
