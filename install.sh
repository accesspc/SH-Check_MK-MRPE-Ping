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

bin_cpt=$(pwd)/bin/check_ping_threaded
plugin_mcp=$(pwd)/plugin/mrpe_check_ping


install -v -m 0644 cron.d/mrpe_check_ping /etc/cron.d/mrpe_check_ping
sed -s -i "s|BIN_CPT|${bin_cpt}|g" /etc/cron.d/mrpe_check_ping

install -v -m 0644 logrotate.d/mrpe_check_ping /etc/logrotate.d/mrpe_check_ping
install -v -m 0755 plugin/mrpe_check_ping /usr/lib/check_mk_agent/plugins/mrpe_check_ping

echo
echo "Finished"
echo
echo "Give at least 2 minutes before discovering in Check_MK"
echo

