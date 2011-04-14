#!perl
use strict;
use warnings;
use ExtUtils::testlib;
use JSON::YAJL;
use Test::Exception;
use Test::More;

my $yajl_default = JSON::YAJL::Generator->new();
isa_ok( $yajl_default, 'JSON::YAJL::Generator' );
is( create($yajl_default),
    '{"integer":123,"double":4,"number":3.141,"string":"a string","string2":"another string","null":null,"true":true,"false":false,"map":{"key":"value","array":[1,2,3]}}'
);

my $yajl_pretty = JSON::YAJL::Generator->new( 1, '   ' );
isa_ok( $yajl_pretty, 'JSON::YAJL::Generator' );
is( create($yajl_pretty), '{
   "integer": 123,
   "double": 4,
   "number": 3.141,
   "string": "a string",
   "string2": "another string",
   "null": null,
   "true": true,
   "false": false,
   "map": {
      "key": "value",
      "array": [
         1,
         2,
         3
      ]
   }
}
'
);

my $yajl_keys_must_be_strings = JSON::YAJL::Generator->new();
$yajl_keys_must_be_strings->map_open();
throws_ok { $yajl_keys_must_be_strings->integer(1) } qr/Keys must be strings/;

my $yajl_generation_complete = JSON::YAJL::Generator->new();
$yajl_generation_complete->map_open();
$yajl_generation_complete->map_close();
throws_ok { $yajl_generation_complete->map_open() } qr/Generation complete/;

my $yajl_max_depth = JSON::YAJL::Generator->new();
foreach my $i ( 1 .. 127 ) {
    $yajl_max_depth->map_open();
    $yajl_max_depth->string("a$i");
}
throws_ok { $yajl_max_depth->map_open() } qr/Max depth exceeded/;

# Only works in 5.8.8 and later
if ( $] > 5.008008 ) {
    my $yajl_invalid_number = JSON::YAJL::Generator->new();
    $yajl_invalid_number->map_open();
    $yajl_invalid_number->string('number');
    throws_ok { $yajl_invalid_number->double( 0 + "inf" ); }
    qr/Invalid number/;
    throws_ok { $yajl_invalid_number->double( 0 + "nan" ); }
    qr/Invalid number/;
}

done_testing();

sub create {
    my $yajl = shift;
    $yajl->map_open();
    $yajl->string("integer");
    $yajl->integer(123);
    $yajl->string("double");
    $yajl->double("4");    # we can't test this in a cross-platform way
    $yajl->string("number");
    $yajl->number("3.141");
    $yajl->string("string");
    $yajl->string("a string");
    $yajl->string("string2");
    $yajl->string("another string");
    $yajl->string("null");
    $yajl->null();
    $yajl->string("true");
    $yajl->bool(1);
    $yajl->string("false");
    $yajl->bool(0);
    $yajl->string("map");
    $yajl->map_open();
    $yajl->string("key");
    $yajl->string("value");
    $yajl->string("array");
    $yajl->array_open();
    $yajl->integer(1);
    $yajl->integer(2);
    $yajl->integer(3);
    $yajl->array_close();
    $yajl->map_close();
    $yajl->map_close();
    return $yajl->get_buf;
}

