#! /bin/bash
# https://docs.couchbase.com/server/current/install/ubuntu-debian-install.html

curl -O https://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb

sudo dpkg -i ./couchbase-release-1.0-amd64.deb
sudo apt-get update

# 
# https://docs.couchbase.com/server/7.0/install/install-swap-space.html
sudo sh -c 'echo 0 > /proc/sys/vm/swappiness'
sudo cp -p /etc/sysctl.conf /etc/sysctl.conf.`date +%Y%m%d-%H:%M`
sudo sh -c 'echo "" >> /etc/sysctl.conf'
sudo sh -c 'echo "#Set swappiness to 0 to avoid swapping" >> /etc/sysctl.conf'
sudo sh -c 'echo "vm.swappiness = 0" >> /etc/sysctl.conf'
sudo apt-get install couchbase-server-community=7.0.1-6102-1