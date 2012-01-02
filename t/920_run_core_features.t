#!perl

use strict;
use warnings;
use FindBin::libs;

use Test::More;
use Test::BDD::Cucumber::Loader;
use Test::BDD::Cucumber::Harness::TermColor;

# Check we actually have these checked out...
Test::More->builder->skip_all('cucumber-features has not been checked out')
	unless -e 't/cucumber_core_features/cucumber-features/';

my ( $executor, @features ) = Test::BDD::Cucumber::Loader->load(
	't/cucumber_core_features/' );

# Just core for now
@features = grep { $_->name eq 'Core: Scenarios, Steps, Mappings' } @features;

my $harness = Test::BDD::Cucumber::Harness::TermColor->new({
	fail_skip => 1
});
fail("Too few tests") unless @features > 1;

$executor->execute( $_, $harness ) for @features;
done_testing;
