package MooseX::InTheRightOrder;

=head1 NAME

MooseX::InTheRightOrder - Ordered has, with, extends

=head1 VERSION

0.00

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

use Moose;

=head1 EXPORTED FUNCTIONS

=head2 extends

=cut

sub extends {
}

=head2 has

=cut

sub has {
}

=head2 with

=cut

sub with {
}

=head1 BUGS

=head1 COPYRIGHT & LICENSE

=head1 AUTHOR

Jan Henning Thorse C<< jhthorsen at cpan.org >>

=cut

1;
