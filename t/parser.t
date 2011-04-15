#!perl
use strict;
use warnings;
use ExtUtils::testlib;
use JSON::YAJL;
use Test::Exception;
use Test::More;

my $yajl_empty = JSON::YAJL::Parser->new();
isa_ok( $yajl_empty, 'JSON::YAJL::Parser' );
throws_ok { $yajl_empty->parse_complete() } qr/unknown error/;

my $yajl = JSON::YAJL::Parser->new();
isa_ok( $yajl, 'JSON::YAJL::Parser' );
my $json
    = '{"integer":123,"double":4,"number":3.141,"string":"a string","string2":"another string","null":null,"true":true,"false":false,"map":{"key":"value","array":[1,2,3]}}';
$yajl->parse($json);
$yajl->parse_complete();

my $yajl_incomplete = JSON::YAJL::Parser->new();
isa_ok( $yajl_incomplete, 'JSON::YAJL::Parser' );
$yajl_incomplete->parse('{"a": 3');
throws_ok { $yajl_incomplete->parse_complete() } qr/unknown error/;

my $yajl_unallowed_token = JSON::YAJL::Parser->new();
isa_ok( $yajl_unallowed_token, 'JSON::YAJL::Parser' );
throws_ok { $yajl_unallowed_token->parse('}') } qr/unallowed token/;

my $yajl_invalid_object_key = JSON::YAJL::Parser->new();
isa_ok( $yajl_invalid_object_key, 'JSON::YAJL::Parser' );
throws_ok { $yajl_invalid_object_key->parse('{ 3: 3}') }
qr/invalid object key/;

done_testing();
