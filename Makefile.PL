use inc::Module::Install;

name q(MooseX-InTheRightOrder);
all_from q(lib/MooseX/InTheRightOrder.pm);

requires q(Moose) => 1.03;
requires q(namespace::autoclean) => 0.09;

test_requires q(Class::MOP) => 1.01;
test_requires q(Test::More) => 0.94;

bugtracker q(http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-InTheRightOrder);
homepage q(http://search.cpan.org/dist/MooseX-InTheRightOrder);
repository q(git://github.com/jhthorsen/moosex-intherightorder.git);

# install_script glob('bin/*');
auto_install;
WriteAll;
