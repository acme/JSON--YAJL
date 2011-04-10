#!perl
use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name    => 'JSON::YAJL',
    license        => 'perl',
    build_requires => { 'ExtUtils::CBuilder' => 0 },
    c_source       => 'yajl',
    needs_compiler => 1,
    sign           => 1,
);
$build->create_build_script;
