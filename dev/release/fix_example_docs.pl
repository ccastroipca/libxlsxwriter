#!/usr/bin/perl

#
# Simple program to arrange the example programs in a user defined order
# instead or sorted order. Also add a caption.
#
# Copyright 2014-2015, John McNamara, jmcnamara@cpan.org
#
use warnings;
use strict;

# The required example order and descriptions.
my @examples = (
    [ 'hello.c',             'A simple hello world example' ],
    [ 'anatomy.c',           'The anatomy of a libxlsxwriter program' ],
    [ 'demo.c',              'Demo of some of the libxlsxwriter features' ],
    [ 'tutorial1.c',         'Tutorial 1 from the documentation' ],
    [ 'tutorial2.c',         'Tutorial 2 from the documentation' ],
    [ 'tutorial3.c',         'Tutorial 3 from the documentation' ],
    [ 'format_font.c',       'Example of writing data with font formatting' ],
    [ 'format_num_format.c', 'Example of writing data with number formatting' ],
    [ 'dates_and_times01.c', 'Writing dates and times with numbers' ],
    [ 'dates_and_times02.c', 'Writing dates and times with datetime' ],
    [ 'dates_and_times03.c', 'Dates and times with different formats' ],
    [ 'utf8.c',              'A example of some UTF-8 text' ],
    [ 'constant_memory.c',   'Write a large file with constant memory usage' ],
);

# Convert the array refs to a hash for lookups.
my %examples;
for my $example (@examples) {
    $examples{$example->[0]} = 1;
}

my $in_list = 0;

while ( my $line = <> ) {

    # Print all lines not in the <ul> list.
    print $line if !$in_list;

    # Check for <ul> list.
    if ( $line =~ /<div class="textblock">/ ) {
        $in_list = 1;
    }

    # Capture the <li> items of the list.
    if ( $line =~ /<li><a class="el" href="[^"]+">([^<]+)/ ) {
        my $example = $1;

        # Warn if there are any new/unkown items.
        if ( !exists $examples{$example} ) {
            warn "Unknown example: $example\n";
        }
        next;
    }

    # At the end of the <ul> list print out the <li> items in user defined order.
    if ( $line =~ m{^</ul>} ) {
        $in_list = 0;

        for my $aref ( @examples ) {
            my $example  = $aref->[0];
            my $filename = $aref->[0];
            my $desc     = $aref->[1];

            $example =~ s/.c/_8c-example.html/;

            printf qq(<li><a class="el" href="%s">%s</a> %s</li>\n\n),
              $example, $filename, $desc;
        }
        print $line;
    }
}

__END__
