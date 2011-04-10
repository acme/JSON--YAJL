#!perl
use strict;
use warnings;
use ExtUtils::testlib;
use JSON::YAJL;
use Test::More;

my $yajl_default = JSON::YAJL->new();
isa_ok( $yajl_default, 'JSON::YAJL' );
is( create($yajl_default),
    '{"integer":123,"double":1.2299999999999999822,"number":3.141,"string":"a string","string2":"another string","map":{"key":"value","array":[1,2,3]}}'
);

my $yajl_pretty = JSON::YAJL->new( 1, '   ' );
isa_ok( $yajl_pretty, 'JSON::YAJL' );
is( create($yajl_pretty), '{
   "integer": 123,
   "double": 1.2299999999999999822,
   "number": 3.141,
   "string": "a string",
   "string2": "another string",
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

done_testing();

sub create {
    my $yajl = shift;
    $yajl->map_open();
    $yajl->string("integer");
    $yajl->integer(123);
    $yajl->string("double");
    $yajl->double("1.23");
    $yajl->string("number");
    $yajl->number("3.141");
    $yajl->string("string");
    $yajl->string("a string");
    $yajl->string("string2");
    $yajl->string("another string");
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

