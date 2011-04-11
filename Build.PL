#!perl
use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name => 'JSON::YAJL',
    dist_abstract =>
        'An interface to the YAJL JSON parsing and generation library',
    dist_author    => 'Leon Brocard <acme@astray.com>',
    license        => 'perl',
    build_requires => { 'ExtUtils::CBuilder' => 0 },
    c_source       => 'yajl',
    needs_compiler => 1,
    create_readme  => 1,
    sign           => 1,
);
$build->create_build_script;
