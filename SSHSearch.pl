#!/usr/bin/perl

# Purdue Computer Science lab computer user search. 
# finds any computers a user is logged into.
# Credit goes to Caleb for all the code that I 
# dissected, including this comment
# Credit goes to Eric Templin for list of Lawson 
# Computers

my $in;
my $name=$ARGV[0];        #username
my $currentComputer;
my @localComputers = ();  #empty array of computer names
my @remoteComputers = (); #empty array of computer names



while($in = <STDIN>) {
  if ($in =~ /@([a-z0-9]*-?[a-z0-9]*)/) {
    $currentComputer = $1;
  } 
  else {
    my $date;
    my $hostname;

    if ($in =~ m/(\w+)(\s+)(\d+)(\s+)(\d+):(\d+)/ ) {
        $date = "$1 $3 $5:$6";
    }

    if ($in =~ m/($name)(\s+)tty/) {
      $str = $currentComputer . " since " . $date;

      push(@localComputers, $str);
    
    } elsif ($in =~ m/($name)(\s+)pts/) {
      if ($in =~ /\(([^\s"]+)\)/) {
        $hostname = $1;
      }
      
      $str = $currentComputer . " from [ " . $hostname . " ] since " . $date;
      
      push(@remoteComputers, $str);
      
    }
  }
}

print "\n";

print "Local connections for $name: \n==============================================\n";

if (@localComputers) {
  foreach (@localComputers) {
    print "$_ \n";
  }
  print "\n";

} else {
  print "No local connections\n\n";
}

print "Remote connections for $name: \n==============================================\n";

if (@remoteComputers) {
  
  foreach (@remoteComputers) {
    print "$_\n";
  }
  print "\n";
} else {
  print "No remote connections\n\n";
}






