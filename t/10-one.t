use strict;
use warnings;
use lib qw(lib t/lib);
use Class::MOP;
use Test::More;

plan tests => 9;

my $obj;

eval {
    Class::MOP::load_class('TestLib');
    1;
};

is($@, '', 'TestLib was loaded successfully') or BAIL_OUT 'Could not load TestLib';
is(TestLib->meta->is_immutable, 1, 'TestLib is immutable');
ok($obj = TestLib->new, 'TestLib object created');
is($obj->will_create_conflict, 'TestLib', 'will_create_conflict() is from TestLib');

ok(!$obj->can('one'), 'obj cannot one');
ok(!$obj->can('with'), 'obj cannot with');
ok(!$obj->can('has'), 'obj cannot has');
ok(!$obj->can('extends'), 'obj cannot extends');
ok(!$obj->can('before'), 'obj cannot before (from Moose)');
