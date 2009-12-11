package MXSimpleConfigTestBase;
use Any::Moose;

has 'inherited_ro_attr' => (is => 'ro', isa => 'Str');

no Any::Moose;
1;

package MXSimpleConfigTest;
use Any::Moose;
extends 'MXSimpleConfigTestBase';
with 'Any::MooseX::SimpleConfig';

has 'direct_attr' => (is => 'ro', isa => 'Int');

has 'req_attr' => (is => 'rw', isa => 'Str', required => 1);

no Any::Moose;
1;
