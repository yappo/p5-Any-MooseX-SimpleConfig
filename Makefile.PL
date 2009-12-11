use inc::Module::Install;
name 'Any-MooseX-SimpleConfig';
all_from 'lib/Any/MooseX/SimpleConfig.pm';
readme_from 'lib/Any/MooseX/SimpleConfig.pm';

requires 'Any::MooseX::ConfigFromFile';
requires 'Config::Any';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
