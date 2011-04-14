package JSON::YAJL::Generator;
use strict;
use warnings;
our $VERSION = '0.05';

require XSLoader;
XSLoader::load( 'JSON::YAJL::Generator', $VERSION );

1;

=head1 NAME

JSON::YAJL::Generator - JSON generation with YAJL

=head1 SYNOPSIS

  use JSON::YAJL::Generator;
  my $yajl = JSON::YAJL::Generator->new();
  # or to beautify (indent):
  #  my $yajl = JSON::YAJL::Generator->new( 1, '    ' );
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
  print $yajl->get_buf;
  $yajl->clear;

  # This prints non-beautified:
  {"integer":123,"double":1.2299999999999999822,"number":3.141,"string":"a string","string2":"another string","null":null,"true":true,"false":false,"map":{"key":"value","array":[1,2,3]}}
  # or beautified:
  {
     "integer": 123,
     "double": 1.2299999999999999822,
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

=head1 DESCRIPTION

This module allows you to generate JSON with YAJL. This is quite a low-level
interface for generating JSON and it accumulates JSON in an internal buffer
until you fetch it.

If you create certain invalid JSON constructs then this module throws an
exception.

This is a very early release to see how cross-platform the underlying code is.
The API may change in future.

=head1 AUTHOR

Leon Brocard <acme@astray.com>

=head1 LICENSE

This module is free software; you can redistribute it or modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<JSON::YAJL>
