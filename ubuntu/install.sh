#! /bin/bash
# https://docs.couchbase.com/server/current/install/ubuntu-debian-install.html

DEFAULT_VERSION='7.0.1-6102-1'
  while [[ $# > 0 ]]; do
    key="$1"

    case "$key" in
      --version)
        version="$2"
        shift
        ;;
      *)
        echo "Unrecognized argument: $key"
        exit 1
        ;;
    esac
    shift
  done

if [[ -z ${version} ]]; then
  version=${DEFAULT_VERSION}
fi

echo "version=${version}"

curl -O https://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb

sudo dpkg -i ./couchbase-release-1.0-amd64.deb
sudo apt-get update

# Disable THP
# https://docs.couchbase.com/server/current/install/thp-disable.html
sudo cp disable-thp.sh /etc/init.d/disable-thp
sudo chmod 755 /etc/init.d/disable-thp
sudo update-rc.d disable-thp defaults

# Configure swap
# https://docs.couchbase.com/server/7.0/install/install-swap-space.html
sudo sh -c 'echo 0 > /proc/sys/vm/swappiness'
sudo cp -p /etc/sysctl.conf /etc/sysctl.conf.`date +%Y%m%d-%H:%M`
sudo sh -c 'echo "" >> /etc/sysctl.conf'
sudo sh -c 'echo "#Set swappiness to 0 to avoid swapping" >> /etc/sysctl.conf'
sudo sh -c 'echo "vm.swappiness = 0" >> /etc/sysctl.conf'

sudo apt-get install couchbase-server-community=${version}