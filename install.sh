#!/bin/bash


exit 0

apt-get purge iperf3 libiperf0
wget https://iperf.fr/download/ubuntu/libiperf0_3.1.3-1_amd64.deb
wget https://iperf.fr/download/ubuntu/iperf3_3.1.3-1_amd64.deb
dpkg -i libiperf0_3.1.3-1_amd64.deb iperf3_3.1.3-1_amd64.deb
rm -vf libiperf0_3.1.3-1_amd64.deb iperf3_3.1.3-1_amd64.deb

echo "Press enter to install as a service or Ctrl+C to stop here"

read

#cp systemd/iperf3.service /etc/systemd/system/iperf3.service
wget -O /etc/systemd/system/iperf3.service http://rrt-wtg.precedenthost.local:3000/TS/sw/raw/master/iperf3/systemd/iperf3.service
systemctl daemon-reload
systemctl enable iperf3.service
systemctl start iperf3.service

