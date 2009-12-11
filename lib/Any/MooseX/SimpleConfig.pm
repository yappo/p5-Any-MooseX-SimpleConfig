package Any::MooseX::SimpleConfig;
use Any::Moose '::Role';
with 'Any::MooseX::ConfigFromFile';

our $VERSION   = '0.04';

use Config::Any ();

sub get_config_from_file {
    my ($class, $file) = @_;

    my $can_config_any_args = $class->can('config_any_args');
    my $extra_args = $can_config_any_args ?
        $can_config_any_args->($class, $file) : {};
    ;
    my $raw_cfany = Config::Any->load_files({
        use_ext => 1,
        %$extra_args,
        files => [ $file ]
    } );

    die q{Specified configfile '} . $file        . q{' does not exist, is empty, or is not readable}
            unless $raw_cfany->[0]
                && exists $raw_cfany->[0]->{$file};

    my $raw_config = $raw_cfany->[0]->{$file};

    die "configfile must represent a hash structure"
        unless $raw_config && ref $raw_config && ref $raw_config eq 'HASH';

    $raw_config;
}

no Any::Moose '::Role';
1;
__END__

=encoding utf8

=head1 NAME

Any::MooseX::SimpleConfig - MooseX::SimpleConfig for Any::Moose

=head1 SYNOPSIS

  ## A YAML configfile named /etc/my_app.yaml:
  foo: bar
  baz: 123

  ## In your class
  package My::App;
  use Moose;

  with 'Any::MooseX::SimpleConfig';

  has 'foo' => (is => 'ro', isa => 'Str', required => 1);
  has 'baz'  => (is => 'rw', isa => 'Int', required => 1);

  # ... rest of the class here

  ## in your script
  #!/usr/bin/Perl
  use My::App;

  my $app = My::App->new_with_config(configfile => '/etc/my_app.yaml');
  # ... rest of the script here
  ####################
  ###### combined with MooseX::Getopt:

=head1 SEE ALSO

L<MooseX::SimpleConfig>

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo <at> shibuya <döt> plE<gt>

And L<MooseX::SimpleConfig> author Brandon L. Black

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
