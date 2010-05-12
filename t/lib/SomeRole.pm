package SomeRole;

use Moose::Role;

has will_create_conflict => (
    is => 'ro',
    isa => 'Str',
    default => 'SomeRole',
);

1;
