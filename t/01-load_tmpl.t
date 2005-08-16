#!perl -T

use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;

BEGIN{ use_ok('CGI::Application'); }

# bring in testing hierarchy
use lib './test';
use TestApp;

$ENV{CGI_APP_RETURN_ONLY} = 1;

LOAD_TMPL_TESTING:
{
    my $app = TestApp->new( TMPL_PATH => [ qw(test/templates) ]);
    ok(my $tmpl = $app->load_tmpl('test.tmpl'), "Created new page template");
    isa_ok($tmpl, "HTML::Template::Pluggable");

    # Make sure setting a bad <tmpl_var> dies
    dies_ok { $tmpl->param( invalid => "BLAH" ) } "Died when setting invalid <tmpl_var>";
}

