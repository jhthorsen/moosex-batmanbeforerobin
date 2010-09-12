use strict;
use warnings;
use lib qw(lib t/lib);
use Class::MOP;
use Test::More;

plan tests => 11;

my $obj;

eval {
    Class::MOP::load_class('TestClass');
    $TestClass::method_in_role = '';
    1;
};

is($@, '', 'TestClass was loaded successfully') or BAIL_OUT 'Could not load TestClass';
is(TestClass->meta->is_immutable, 1, 'TestClass is immutable');
ok($obj = TestClass->new, 'TestClass object created');
is($obj->will_create_conflict, 'TestClass', 'will_create_conflict() is from TestClass');

ok(!$obj->can('one'), 'obj cannot one');
ok(!$obj->can('with'), 'obj cannot with');
ok(!$obj->can('has'), 'obj cannot has');
ok(!$obj->can('extends'), 'obj cannot extends');
ok(!$obj->can('before'), 'obj cannot before (from Moose)');

is($obj->method_in_role, 2, 'around modifier applied');
is($TestClass::method_in_role, 'ba', 'before/after modifier applied');

