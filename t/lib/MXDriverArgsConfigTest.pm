package MXDriverArgsConfigTestBase;
use Any::Moose;

has 'inherited_ro_attr' => (is => 'ro', isa => 'Str');

no Any::Moose;
1;

package MXDriverArgsConfigTest;
use Any::Moose;
extends 'MXDriverArgsConfigTestBase';
with 'Any::MooseX::SimpleConfig';

has 'direct_attr' => (is => 'ro', isa => 'Int');

has 'req_attr' => (is => 'rw', isa => 'Str', required => 1);

sub config_any_args {
    return +{
        driver_args => {
            General => {
                -LowerCaseNames => 1
            }
        }
    }
}

no Any::Moose;
1;
