#!perl
use strict;
use warnings;
use Data::Dumper;
use JSON::YAJL;

my $filename = shift || die 'Please pass a JSON filename to reformat';

my @tokens;

my $text;
my $parser = JSON::YAJL::Parser->new(
    0, 0,
    [   sub {
            push @tokens, ['null'];
        },
        sub {
            push @tokens, ['bool'];
        },
        undef,
        undef,
        sub {
            push @tokens, [ 'number', shift ];
        },
        sub {
            push @tokens, [ 'string', shift ];
        },
        sub {
            push @tokens, ['map_open'];
        },
        sub {
            push @tokens, [ 'key', shift ];
        },
        sub {
            push @tokens, ['map_close'];
        },
        sub {
            push @tokens, ['array_open'];
        },
        sub {
            push @tokens, ['array_close'];
        },
    ]
);
my $json
    = '{"integer":123,"double":4,"number":3.141,"string":"a string","string2":"another string","null":null,"true":true,"false":false,"map":{"key":"value","array":[1,2,3]}}';
$parser->parse($json);
$parser->parse_complete();

print Dumper( \@tokens );
