#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Copy qw( copy );

my $cwd = $FindBin::Bin;
my $enc = "UTF-8";

# Gitflow.
print( "Initalizing gitflow configuration.\n" );

my $f_git_config     = "$cwd/.git/config";
my $f_git_config_tmp = "$cwd/.git/config_tmp_12345678901";

unlink $f_git_config_tmp if -f $f_git_config_tmp;

my @gitflow_config = (
    '[gitflow "branch"]',
        'master = master',
        'develop = dev',
    '[gitflow "prefix"]',
        'feature = feature/',
        'bugfix = bugfix/',
        'release = release/',
        'hotfix = hotfix/',
        'support = support/',
        'versiontag = v',
    '[gitflow "path"]',
        'hooks = /_/pr/me/web/ui-pulsar-msk/.git/hooks',
);

# Loop through git config file.
open( my $fh_git_config,     "<:encoding( $enc )",  $f_git_config );
open( my $fh_git_config_tmp, ">>:encoding( $enc )", $f_git_config_tmp );

# Delete existing gitflow config.
my $b_next = 0;
while( my $line = <$fh_git_config> )
{
    chomp $line;
    if ( $line =~ /\[.*\]/ )
    {
        $b_next = 0;
    }
    if ( $line =~ /\[\s*gitflow/ )
    {
        $b_next = 1;
    }
    next if $b_next;
    print $fh_git_config_tmp "$line\n";
}
undef $b_next;
close( $fh_git_config );

# Add new gitflow config.
while( my $line = shift( @gitflow_config ) )
{
    $line = "\t$line" unless $line =~ /\[.*\]/;
    print $fh_git_config_tmp "$line\n";
}
close( $fh_git_config_tmp );

# Copy tmp config to real one.
copy( $f_git_config_tmp, $f_git_config );


print( "Finished successfully.\n" );
1;
