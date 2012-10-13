#!/usr/bin/perl
# nclock.pl
# 
# http://i.imgur.com/3uR86.jpg
# breakdown
    #half, ten, quarter, twenty, five, minutes
    #to, past
    #one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
    #o'clock

use strict;
use warnings;

package nclock;

my %intervals = (
    # only takes care of the 'past' direction right now
    half    => sub { return ($_[0] > 20 and $_[0] < 45) ? 1 : undef },
    ten     => sub { return ($_[0] > 5  and $_[0] < 15) ? 1 : undef },
    quarter => sub { return ($_[0] > 10 and $_[0] < 20) ? 1 : undef },
    twenty  => sub { return ($_[0] > 20 and $_[0] < 40) ? 1 : undef },
    five    => sub { return ($_[0] > 0  and $_[0] < 10) ? 1 : undef },
);

my %side = (
    to   => sub { },
    past => sub { },
);

my @times = ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve');

my %postfix = (
    "o'clock" => sub { return ($_[0] == 0) ? 1 : undef },
);

unless (caller(0)) {
    
    my $input = shift;
    my $output = transform($input) || 'ERROR';
    print "$output\n";
    
    exit;
}

## subs below

sub transform {
    my ($input) = @_;
    
    return is_valid($input);
    
}

sub is_valid {
    # is_valid($str) - returns 1|undef
    my ($str)   = @_;
    my $results = 1;
    
    $results = undef if $str =~ /[a-z]+/i;
    $results = undef if $str !~ /(\d+)\:(\d+)/;
    
    if ($1 and $2) { 
        $results = undef if $1   > 23 or $1 < 0;
        $results = undef if $2   > 60 or $2 < 0;
    }
    
    return $results;
}

