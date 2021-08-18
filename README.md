# gitflow-init
Standardized gitflow config.

Add this code to your project's root to automate `git flow init` operation.
Then invoke it as usual.

```perl
#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

my $cwd = $FindBin::Bin;

# Gitflow.
my $gitflow   = "gitflow-init";
my $d_gitflow = "$cwd/$gitflow";

print( "GITFLOW.\n" );

# Clone the repo or pull it if the directory already exists.
unless ( -d $d_gitflow )
{
    `git clone git\@github.com:dta90d/$gitflow.git`;
}
else
{
    chdir $d_gitflow;
    `git pull`;
}

# Run init.pl script.
my $f_exec = "$d_gitflow/init.pl";
if ( -f $f_exec )
{
    # local @ARGV = ( "" );
    do $f_exec;
}
else
{
    die "\nError: No such file $f_exec.\n\nPossible solution:\nrm -r $d_gitflow\nperl $0\n\n";
}

# .gitignore.
my $f_gitignore = "$cwd/.gitignore";
unless ( -f "$f_gitignore" and `grep "$gitflow/" $f_gitignore` )
{
    `echo "$gitflow/" >> $f_gitignore`;
    print( "Added $gitflow/ to .gitignore\n\n" );
}

# Success.
print( "GITFLOW end.\n" );

1;
```
