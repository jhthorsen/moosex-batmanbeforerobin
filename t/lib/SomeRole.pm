package SomeRole;

use Moose::Role;

has will_create_conflict => (
    is => 'ro',
    isa => 'Str',
    default => 'SomeRole',
);

sub method_in_role {
    return 1;
}

1;
