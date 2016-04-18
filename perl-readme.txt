mkdir perl
cd perl
wget foo-bar-1.0.0.tar.gz
tar xzf foo-bar-1.0.0.tar.gz
cd foo-bar-1.0.0
perl Makefile.PL INSTALL_BASE=../..
make install


# http://stackoverflow.com/questions/540640/how-can-i-install-a-cpan-module-into-a-local-directory
# http://stackoverflow.com/questions/2980297/how-can-i-use-cpan-as-a-non-root-user

# http://search.cpan.org/~miyagawa/App-cpanminus-1.7039/lib/App/cpanminus.pm

curl -L https://cpanmin.us | perl - App::cpanminus
# or
yum -y perl-ExtUtils-MakeMaker perl-Digest-SHA gcc

wget -O - http://cpanmin.us | perl - --self-upgrade

# Install local::lib
# http://search.cpan.org/~haarg/local-lib-2.000015/lib/local/lib.pm
cpanm --local-lib=~/perl5 local::lib && eval $( perl -I ~/perl5/lib/perl5/ -Mlocal::lib )
# Add to .bashrc, sets PATH and PERL5_LIB etc:
[ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# Install Carton
# http://search.cpan.org/~miyagawa/Carton-v1.0.21/lib/Carton.pm
cpanm Carton

# Set up project
echo 'local/' >> .gitignore
#vim cpanfile cpanfile.snapshot
echo -e "#requires 'Modern::Perl';\n#requires 'Plack', '0.9980';" | tee cpanfile > cpanfile.snapsho
carton install

# in main.pl
use FindBin;
#use local::lib "$FindBin::Bin/perl5lib/lib";
use lib "$FindBin::Bin/../lib/perl5";
