use inc::Module::Install;

name q(MooseX-BatmanBeforeRobin);
all_from q(lib/MooseX/BatmanBeforeRobin.pm);

requires q(Moose) => 1.00;
requires q(namespace::autoclean) => 0.09;

test_requires q(Class::MOP) => 1.00;
test_requires q(Test::More) => 0.90;

bugtracker q(http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-BatmanBeforeRobin);
homepage q(http://search.cpan.org/dist/MooseX-BatmanBeforeRobin);
repository q(git://github.com/jhthorsen/moosex-batmanbeforerobin.git);

# install_script glob('bin/*');
auto_install;
WriteAll;
