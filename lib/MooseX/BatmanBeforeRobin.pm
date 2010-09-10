package MooseX::BatmanBeforeRobin;

=head1 NAME

MooseX::BatmanBeforeRobin - Ordered Moose sugar

=head1 VERSION

0.0201

=head1 SYNOPSIS

    package MyClass;
    use MooseX::BatmanBeforeRobin;

    extends ...;
    with ...;
    has ...;

    one; # instead of 1;

=head1 DESCRIPTION

This class will take over some of the exported functions from L<Moose>
and call them in "the right order":

    1: extends()
    2: has()
    3: with()
    4: override()/augment()
    5: before()/after()/around()

This is done by stashing the statements away, and applying them once
the L</one> function is called. An alternative to L</one> is
L</__PACKAGE__>, which allows you to do

    (require MyMoose::Class)->some_method;

since C<require> will return the last value in the package.

This module will also export all other functions from L<Moose>, so
C<use Moose> is not required.

=cut

use Moose ();
use namespace::autoclean ();
use Moose::Exporter;

our $VERSION = eval '0.0201';

Moose::Exporter->setup_import_methods(
    with_meta => [qw/ one __PACKAGE__ /],
    as_is => [qw/ extends has with override augment before after around /],
    also => 'Moose',
);

my(@extends, @has, @with, @inherit, @modifier);

=head1 EXPORTED FUNCTIONS

See L<Moose>.

=cut

BEGIN {
    *extends = sub { push @extends, [@_] };
    *has = sub { push @has, [@_] };
    *with = sub { push @with, [@_] };
    *override = sub { push @inherit, ['Moose::override' => @_] };
    *augment = sub { push @inherit, ['Moose::augment' => @_] };
    *before = sub { push @modifier, ['Moose::before' => @_] };
    *after = sub { push @modifier, ['Moose::after' => @_] };
    *around = sub { push @modifier, ['Moose::around' => @_] };
}

=head2 one

This function should replace C<1;> on the last line in your class.
It will call the L<Moose> keywords in "the right order" and
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
    for my $inherit (@inherit) {
        my $moose_method = shift @$inherit;
        $meta->$moose_method(@$inherit);
    }
    for my $modifier (@modifier) {
        my $moose_method = shift @$modifier;
        $meta->$moose_method(@$modifier);
    }

    # clear the variables for the next module load
    @extends = @has = @with = @inherit = @modifier = ();

    $meta->make_immutable;
 
    return 1;
}

=head2 __PACKAGE__

Alternative to L</one>.

=cut

sub __PACKAGE__ {
    my $meta = shift;
    $meta->MooseX::BatmanBeforeRobin::one(@_);
    return $meta->name;
}

=head1 METHODS

=head2 init_meta

This method is called on C<import()> and sets up L<namespace::autoclean>
and L<Moose>.

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

Jan Henning Thorsen C<< jhthorsen at cpan.org >>

=cut

1;
