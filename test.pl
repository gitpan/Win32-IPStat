# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Win32::IPStat;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

use Data::Dumper;

my $error = undef;
my $STAT = Win32::IPStat->new();
my $return = $STAT->GetStat($error);
my @a = @{ $return };
my %h = %{ $a[0] };
foreach my $key (keys %h)
{
	my $val = $h{$key};
	print "$key = $val\n";
}