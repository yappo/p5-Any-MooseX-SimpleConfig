#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib';
use lib '../t/lib';

BEGIN {
    use Test::More;

    eval "use YAML::Syck ()";
    if($@) {
        eval "use YAML ()";
        if($@) {
            plan skip_all => "YAML or YAML::Syck required for this test";
        }
    }
    
    plan tests => 5;

    use_ok('MXDefaultConfigTest');
}

# Can it load a simple YAML file with the options
#  based on a default in the configfile attr
{
    open(my $test_yaml, '>', 'test.yaml')
      or die "Cannot create test.yaml: $!";
    print $test_yaml "direct_attr: 123\ninherited_ro_attr: asdf\nreq_attr: foo\n";
    close($test_yaml);

    my $foo = eval {
        MXDefaultConfigTest->new_with_config();
    };
    ok(!$@, 'Did not die with good YAML configfile')
        or diag $@;

    is($foo->req_attr, 'foo', 'req_attr works');
    is($foo->direct_attr, 123, 'direct_attr works');
    is($foo->inherited_ro_attr, 'asdf', 'inherited_ro_attr works');
}

END { unlink('test.yaml') }
