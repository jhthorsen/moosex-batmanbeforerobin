package TestLib;

use strict;
use warnings;
use MooseX::InTheRightOrder;

with 'SomeRole';

has is_an_attribute => (
    is => 'ro',
    isa => 'Bool',
);

has will_create_conflict => (
    is => 'ro',
    isa => 'Str',
    default => 'TestLib',
);

one;
