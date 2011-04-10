package JSON::YAJL;
use strict;
use warnings;
our $VERSION = '0.01';

require XSLoader;
XSLoader::load( 'JSON::YAJL', $VERSION );

1;
