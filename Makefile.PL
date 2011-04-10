#!perl
use warnings;
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'JSON::YAJL',
    VERSION_FROM => 'lib/JSON/YAJL.pm',
    INC          => "-Iyajl",
);
