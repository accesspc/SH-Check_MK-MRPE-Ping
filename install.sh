#!/bin/bash
#set -x 

if [ ! -x /usr/lib/nagios/plugins/check_ping ] ; then
	echo "nagios-plugins is not installed"
	exit 1
fi

if [ ! -x /usr/lib/check_mk_agent/plugins ] ; then
	echo "check_mk_agent is not installed"
	exit 1
fi

echo "Installing"
cwd=`pwd`

cron_mcp=/etc/cron.d/mrpe_check_ping
bin_cpt=$(pwd)/bin/check_ping_threaded
plugin_mcp=$(pwd)/plugin/mrpe_check_ping

if [ -x ${cron_mcp} ] ; then
	echo "Cron '${cron_mcp}' already exists. Overwritting..."
else
	echo "New cron job: ${cron_mcp}"
fi



echo "# 
# cron.d/mrpe_check_ping -- schedules threaded check_mk check_ping every minute
# 
* *	* * *	root	if [ -x ${bin_cpt} ]; then ${bin_cpt}; fi" > ${cron_mcp}
cat ${cron_mcp}

install -m 0755 plugin/mrpe_check_ping /usr/lib/check_mk_agent/plugins/mrpe_check_ping

echo "Finished"
echo
echo "Give at least 2 minutes before discovering in Check_MK"
echo

