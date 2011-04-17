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
    requires       => { 'Test::More' => 0, 'Test::Exception' => 0 },
    c_source       => 'yajl',
    needs_compiler => 1,
    create_readme  => 1,
    sign           => 1,
    meta_add       => {
        resources => {
            homepage   => 'http://search.cpan.org/dist/JSON-YAJL/',
            repository => 'https://github.com/acme/JSON--YAJL',
            bugtracker =>
                'http://rt.cpan.org/NoAuth/Bugs.html?Dist=JSON-YAJL',
        },
    },
);
$build->create_build_script;
