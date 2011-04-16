#!perl
use strict;
use warnings;
use ExtUtils::testlib;
use JSON::YAJL;
use Test::Exception;
use Test::More;

my $text;
my $yajl_callbacks = JSON::YAJL::Parser->new(
    0, 0,
    [   sub { $text .= "null\n" },
        sub { $text .= "boolean: @_\n" },
        undef,
        undef,
        sub { $text .= "number: @_\n" },
        sub { $text .= "string: @_\n" },
        sub { $text .= "start_map\n" },
        sub { $text .= "map_key: @_\n" },
        sub { $text .= "end_map\n" },
        sub { $text .= "start_array\n" },
        sub { $text .= "end_array\n" },
    ]
);
isa_ok( $yajl_callbacks, 'JSON::YAJL::Parser' );
my $json
    = '{"integer":123,"double":4,"number":3.141,"string":"a string","string2":"another string","null":null,"true":true,"false":false,"map":{"key":"value","array":[1,2,3]}}';
$yajl_callbacks->parse($json);
$yajl_callbacks->parse_complete();
is( $text, 'start_map
map_key: integer
number: 123
map_key: double
number: 4
map_key: number
number: 3.141
map_key: string
string: a string
map_key: string2
string: another string
map_key: null
null
map_key: true
boolean: 1
map_key: false
boolean: 0
map_key: map
start_map
map_key: key
string: value
map_key: array
start_array
number: 1
number: 2
number: 3
end_array
end_map
end_map
'
);

my $yajl = JSON::YAJL::Parser->new( 0, 0, [] );
isa_ok( $yajl, 'JSON::YAJL::Parser' );
$yajl->parse($json);
$yajl->parse_complete();

my $yajl_empty = JSON::YAJL::Parser->new( 0, 0, [] );
isa_ok( $yajl_empty, 'JSON::YAJL::Parser' );
throws_ok { $yajl_empty->parse_complete() } qr/unknown error/;

my $yajl_incomplete = JSON::YAJL::Parser->new( 0, 0, [] );
isa_ok( $yajl_incomplete, 'JSON::YAJL::Parser' );
$yajl_incomplete->parse('{"a": 3');
throws_ok { $yajl_incomplete->parse_complete() } qr/unknown error/;

my $yajl_unallowed_token = JSON::YAJL::Parser->new( 0, 0, [] );
isa_ok( $yajl_unallowed_token, 'JSON::YAJL::Parser' );
throws_ok { $yajl_unallowed_token->parse('}') } qr/unallowed token/;

my $yajl_invalid_object_key = JSON::YAJL::Parser->new( 0, 0, [] );
isa_ok( $yajl_invalid_object_key, 'JSON::YAJL::Parser' );
throws_ok { $yajl_invalid_object_key->parse('{ 3: 3}') }
qr/invalid object key/;

done_testing();
