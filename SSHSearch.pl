#!/usr/bin/perl

# Purdue Computer Science lab computer user search. 
# finds any computers a user is logged into.
# Credit goes to Caleb for all the code that I 
# dissected, including this comment
# Credit goes to Eric Templin for list of Lawson 
# Computers

my $in;
my $username;
my $first;
my $last;

my $username = $ARGV[0];
my $currentComputer;
my @localComputers = ();
my @remoteComputers = ();


while($in = <STDIN>) {

	# remember current computer name
	if ($in =~ /@([a-z0-9]*-?[a-z0-9]*)/) {
		$currentComputer = $1;

	# user found
	} else {
		my $date;
		my $hostname;

		# get date of login
		if ($in =~ m/(\w+)(\s+)(\d+)(\s+)(\d+):(\d+)/ ) {
				$date = "$1 $3 $5:$6";
		}

		# logged in locally
		if ($in =~ m/($username)(\s+)tty/) {
			$str = $currentComputer . " since " . $date;
			push(@localComputers, $str);
		
		# logged in remotely
		} elsif ($in =~ m/($username)(\s+)pts/) {
			if ($in =~ /\(([^\s"]+)\)/) {
				$hostname = $1;
			}
			$str = $currentComputer . " from [ " . $hostname . " ] since " . $date;
			push(@remoteComputers, $str);
		}
	}
} 

print "\nLocal connections for $username: \n==============================================\n";

if (@localComputers) {
	foreach (@localComputers) {
		print "$_ \n";
	}
	print "\n";

} else {
	print "No local connections\n\n";
}

print "Remote connections for $username: \n==============================================\n";

if (@remoteComputers) {
	
	foreach (@remoteComputers) {
		print "$_\n";
	}
	print "\n";
} else {
	print "No remote connections\n\n";
}







#my $num_args = $#ARGV+1;
#for ($i=0; $i<$num_args; $i++) {
#	if ($ARGV[$i] eq "-u") {
#		$i++;
#		$username = $ARGV[$i];
#	} elsif ($ARGV[$i] eq "-f") {
#		$i++;
#		$first = $ARGV[$i];
#	} elsif (@ARGV[$i] eq "-l") {
#		$i++;
#		$last = $ARGV[$i];
#	}
#}
#if ( !$username ) {
#	if (!$first || !$last) {
#		print STDERR "Must include both first and last name\n";
#		exit;
#	} 	
#
#	system();
#
#
#
#}


