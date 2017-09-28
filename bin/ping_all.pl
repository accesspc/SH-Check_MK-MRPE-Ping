#!/usr/bin/perl
use threads;
use FileHandle;

open (CFG, "cat /etc/check_mk/mrpe-check_ping.cfg |") or die "Can't open config file\n";

while ( <CFG> ) {
	print "Line: $_ \n";
}


die("Premature");

$run = 1;
while($run) {
	@running = threads->list(threads::running);
	$nrunning = @running;
	if ($nrunning < 1) {
		$run = 0;
	}
	sleep(1);
}

print "All threads are running";

sub ping_thread {
	my @data = @_;
	$ping_command = @data[0];
	$handle = PING."@data[1]";
	
	# Starting check_ping"
	open($handle, "$ping_command 2>&1 |") or die "Can't start ping process!\n";
	$oldh = select($handle);
	$| = 1;
	select($oldh);

	$ping_count = 0;

	while ( <$handle> ) {
		chomp;
		s/^\s+|\s+$//;
		print STDOUT "$? : $_";
		$ping_count++;
	}
	close(PING);
}
print "Finished \n";

