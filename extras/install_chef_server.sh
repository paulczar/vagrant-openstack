#!/bin/bash -x

cd /tmp
echo downloading chef-server debian package.  this may take some time...
wget --quiet https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.6-1.ubuntu.12.04_amd64.deb
dpkg -i chef-server*.deb
chef-server-ctl reconfigure


mkdir -p /home/vagrant/.chef
sudo cp /etc/chef-server/admin.pem /home/vagrant/.chef/
sudo cp /etc/chef-server/chef-validator.pem /home/vagrant/.chef/
mkdir -p /vagrant/.chef
cp /home/vagrant/.chef/* /vagrant/.chef/

cat<<KNIFE > /home/vagrant/.chef/knife.rb
log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/home/vagrant/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '.chef/chef-validator.pem'
chef_server_url          'https://chef'
cache_type               'BasicFile'
cache_options( :path => '/home/vagrant/.chef/checksums' )
KNIFE

chown vagrant. /vagrant/.chef/*
chown vagrant. /home/vagrant/.chef/*
