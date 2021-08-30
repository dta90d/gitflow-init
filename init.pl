#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

my $cwd = $FindBin::Bin;
my $enc = "UTF-8";

# Gitflow.
print( "\nInitalizing gitflow configuration.\n" );

`git config gitflow.branch.master master`;
`git config gitflow.branch.develop dev`;
`git config gitflow.prefix.feature feature/`;
`git config gitflow.prefix.bugfix bugfix/`;
`git config gitflow.prefix.release release/`;
`git config gitflow.prefix.hotfix hotfix/`;
`git config gitflow.prefix.support support/`;
`git config gitflow.prefix.versiontag v`;
`git config gitflow.path.hooks $cwd/.git/hooks`;

`cd $cwd && git checkout -t origin/master`;

print( "Finished successfully.\n\n" );
1;
