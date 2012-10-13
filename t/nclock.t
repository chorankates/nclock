#!/usr/bin/perl
# nclock.t
# 
# http://i.imgur.com/3uR86.jpg
# breakdown
    #half, ten, quarter, twenty, five, minutes
    #to, past
    #one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
    #o'clock

use strict;
use warnings;

use Test::More qw(no_plan);

use lib '.';
use lib '..';
require 'nclock.pl';

my %good_times = (
    '08:00' => "eight o'clock",
    '12:20' => "quarter past twelve",
    '13:15' => "quarter past one", # need to support both 12|24 hour times
    '1:15'  => "quarter past one",
    '02:31' => "half past three",
    '2:25'  => "twenty five minutes past two",
    '2:45'  => "quarter to three",
    '03:01' => "three o'clock",
    '6:15'  => "quarter past six",
    '8:05'  => "five minutes past eight",
    '8:40'  => "twenty minutes to nine",
    '8:50'  => "ten minutes to nine",
    '00:00' => "twelve o'clock",
);

for my $input (keys %good_times) {
    my $output = nclock::transform($input);
    
    is ($good_times{$input}, $output, sprintf('good [%s]', $input));
}


my @bad_times = (
    'foo',
    0,
    1,
    '16:65',    
);

for my $input (@bad_times) {
    my $output = nclock::transform($input);
    
    is ($output, undef, sprintf('bad [%s]', $input));
}

exit;
