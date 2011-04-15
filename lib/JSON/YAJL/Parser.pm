package JSON::YAJL::Parser;
use strict;
use warnings;
our $VERSION = '0.05';

require XSLoader;
XSLoader::load( 'JSON::YAJL::Parser', $VERSION );

1;

=head1 NAME

JSON::YAJL::Parser - JSON parsing with YAJL

=head1 SYNOPSIS

  use JSON::YAJL::Generator;

=head1 DESCRIPTION

This module allows you to parser JSON with YAJL. This is quite a low-level
interface for parsing JSON.

This is a very early release to see how cross-platform the underlying code is.
The API may change in future.

=head1 AUTHOR

Leon Brocard <acme@astray.com>

=head1 LICENSE

This module is free software; you can redistribute it or modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<JSON::YAJL>, L<JSON::YAJL::Generator>
