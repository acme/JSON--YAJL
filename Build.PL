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
    create_license => 1,
    create_readme  => 1,
    sign           => 1,
    meta_merge     => {
        resources => {
            homepage   => 'http://search.cpan.org/dist/JSON-YAJL/',
            repository => {
                url  => 'https://github.com/acme/JSON--YAJL',
                web  => 'git@github.com:acme/JSON--YAJL.git',
                type => 'git',
            },
            bugtracker => {
                web => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=JSON-YAJL',
                mailto => 'bug-JSON-YAJL@rt.cpan.org',
            }
        },
    },
    'meta-spec' => {
        version => '2',
        url     => 'http://search.cpan.org/perldoc?CPAN::Meta::Spec',
    },
);
$build->create_build_script;
