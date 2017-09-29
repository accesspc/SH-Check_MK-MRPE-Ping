#!/bin/bash

if [ ! -x /usr/lib/nagios/plugins/check_ping ] ; then
	echo "nagios-plugins package is not installed"
	exit 1
fi

echo "Installing"
cwd=`pwd`

if [ -x /etc/cron.d/mrpe_check_ping ] ; then
	echo "Cron '/etc/cron.d/mrpe_check_ping' already exists"
	echo "Overwritting..."
fi

mcp=$(pwd)/bin/mrpe-check_ping

echo "# 
# cron.d/mrpe_check_ping -- schedules threaded check_mk check_ping every minute
# 
* *	* * *	root	if [ -x ${mcp} ]; then ${mcp}; fi" > /etc/cron.d/mrpe_check_ping

echo "Finished"

