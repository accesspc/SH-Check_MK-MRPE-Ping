#!/bin/bash
#set -x 

if [ ! -x /usr/lib/nagios/plugins/check_ping ] ; then
	if [ ! -x /usr/lib64/nagios/plugins/check_ping ] ; then
		echo "nagios-plugins is not installed"
		exit 1
	fi
fi

if [ ! -x /usr/lib/check_mk_agent/plugins ] ; then
	echo "check_mk_agent is not installed"
	exit 1
fi

if [ $(dirname "$0") != "." ] ; then
	echo "Script must be run from its own directory"
	exit 1
fi

echo "Installing"

chown -R root:root .

bin_cpt=$(pwd)/bin/check_ping_threaded
plugin_mcp=$(pwd)/plugin/mrpe_check_ping


install -v -m 0644 cron.d/mrpe_check_ping /etc/cron.d/mrpe_check_ping
sed -s -i "s|BIN_CPT|${bin_cpt}|g" /etc/cron.d/mrpe_check_ping

install -v -m 0644 logrotate.d/mrpe_check_ping /etc/logrotate.d/mrpe_check_ping
install -v -m 0755 plugin/mrpe_check_ping /usr/lib/check_mk_agent/plugins/mrpe_check_ping

touch /etc/check_mk/mrpe_check_ping.cfg

echo 
echo "Please update /etc/check_mk/mrpe_check_ping.cfg file with ping services in 'mrpe' syntax, e.g.:"
echo 'Ping-Google-8.8.8.8   /usr/lib/nagios/plugins/check_ping -H 8.8.8.8 -w200,5% -c 500,20% -p 30'
echo

echo
echo "Finished"
echo
echo "Give at least 2 minutes before discovering in Check_MK"
echo

