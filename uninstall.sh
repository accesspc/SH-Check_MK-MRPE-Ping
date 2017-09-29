#!/bin/bash
set -x 

rm -vf /etc/cron.d/mrpe_check_ping
rm -vf /etc/logrotate.d/mrpe_check_ping
rm -vf /usr/lib/check_mk_agent/plugins/mrpe_check_ping
rm -vf /var/log/mrpe_check_ping.log*
rm -rvf /tmp/mrpe
