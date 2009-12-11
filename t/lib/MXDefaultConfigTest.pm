package MXDefaultConfigTestBase;
use Any::Moose;

has 'inherited_ro_attr' => (is => 'ro', isa => 'Str');

no Any::Moose;
1;

package MXDefaultConfigTest;
use Any::Moose;
use Path::Class::File;
extends 'MXDefaultConfigTestBase';
with 'Any::MooseX::SimpleConfig';

has 'direct_attr' => (is => 'ro', isa => 'Int');

has 'req_attr' => (is => 'rw', isa => 'Str', required => 1);

has '+configfile' => ( default => 'test.yaml' );

no Any::Moose;
1;
