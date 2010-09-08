package TestClass;

use strict;
use warnings;
use MooseX::BatmanBeforeRobin;

our $method_in_role = '';

before method_in_role => sub {
    $method_in_role .= 'b';
};

after method_in_role => sub {
    $method_in_role .= 'a';
};

around method_in_role => sub {
    my $next = shift;
    my $self = shift;

    return $self->$next + 1;
};

with 'SomeRole';

has is_an_attribute => (
    is => 'ro',
    isa => 'Bool',
);

has will_create_conflict => (
    is => 'ro',
    isa => 'Str',
    default => 'TestClass',
);

__PACKAGE__;
