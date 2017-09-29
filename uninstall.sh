#!/bin/bash
set -x 

rm -vf /etc/cron.d/mrpe_check_ping
rm -vf /usr/lib/check_mk_agent/plugins/mrpe_check_ping
