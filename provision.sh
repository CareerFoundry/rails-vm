#!/bin/bash -l

# fix apt-get update taking forever due to ipv6, disable it
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf

sudo apt-add-repository ppa:team-gotty/gotty -y;
sudo apt-get update;

# for mentors to get shell access to the VM
apt-get --yes --force-yes install gotty ngrok-client tmux;

# install dependencies for gems such as pg, nokogiri, etc.
apt-get --yes --force-yes install build-essential postgresql libpq-dev zlibc zlib1g zlib1g-dev sqlite3 libsqlite3-dev nodejs libxslt-dev libxml2-dev;

# install Heroku Toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh;

# install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; curl -sSL https://get.rvm.io | bash -s stable;
