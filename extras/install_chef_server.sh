#!/bin/bash -x

if [ ! -f /home/vagrant/.chef/knife.db ]
then
  echo "Preparing to install chef client..."
  mkdir -p /vagrant/packages
  cd /vagrant/packages
  echo downloading chef-server debian package.  this may take some time...
  wget -nc --quiet https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.6-1.ubuntu.12.04_amd64.deb
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

  chown vagrant /vagrant/.chef/*
  chown vagrant /home/vagrant/.chef/*

  echo "Chef server installed!!\nNow let us configure up the cookbooks."
  cd /vagrant/chef-cookbooks
  knife cookbook upload -o cookbooks --all
  knife role from file roles/*.rb
  knife environment from file /vagrant/extras/environment_vagrant.json
  knife node from file /vagrant/extras/allinone_node.json
  knife node from file /vagrant/extras/single_controller_node.json
  knife node from file /vagrant/extras/single_compute_node.json


else
  echo "chef server already installed!"
fi
