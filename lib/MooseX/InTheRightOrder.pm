package MooseX::InTheRightOrder;

=head1 NAME

MooseX::InTheRightOrder - Ordered has, with, extends

=head1 VERSION

0.01

=head1 DESCRIPTION

This class will take over some of the exported functions from L<Moose>
and call them in "the right order".

=head1 SYNOPSIS

 package MyClass;
 use MooseX::InTheRightOrder;

 extends ...;
 with ...;
 has ...;

 one; # instead of 1;

=cut

use Moose ();
use namespace::autoclean ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    with_meta => [qw/ one /],
    as_is => [qw/ extends has with /],
    also => 'Moose',
);

my(@has, @with, @extends);

=head1 EXPORTED FUNCTIONS

=head2 extends

This function will cache all classes which you want to extend your class
with and then load them before C<has()> and C<with()> inside L</one()>.

=cut

sub extends {
    push @extends, [@_];
}

=head2 has

This function will cache all attributes which you want to define in your
class and then define them after C<extends()>, but before C<with()>
inside L</one()>.

=cut

sub has {
    push @has, [@_];
}

=head2 with

This function will cache all roles which you want to do in your class
and then include them after C<extends()> and C<has()> inside L</one()>.

=cut

sub with {
    push @with, [@_];
}

=head2 one

This function should replace C<1;> on the last line in your class. It
will run C<extends>, C<has()> and C<with()> in "the right order". And
afterwards make the class immutable and clear the namespace, using
L<namespace::autoclean>.

=cut

sub one {
    my $meta = shift;

    for my $extends (@extends) {
        $meta->Moose::extends(@$extends);
    }
    for my $has (@has) {
        $meta->Moose::has(@$has);
    }
    for my $with (@with) {
        $meta->Moose::with(@$with);
    }

    @extends = @has = @with = ();

    $meta->make_immutable;
 
    return 1;
}

=head1 METHODS

=heda2 init_meta

This method is called on C<import()> and sets up L<namespace::autoclean>.

=cut

sub init_meta {
    shift;
    my %options = @_;

    Moose->init_meta(%options);
    namespace::autoclean->import(-cleanee => $options{'for_class'});

    return $options{'for_class'}->meta;
}

=head1 BUGS

=head1 COPYRIGHT & LICENSE

=head1 AUTHOR

Jan Henning Thorse C<< jhthorsen at cpan.org >>

=cut

1;
