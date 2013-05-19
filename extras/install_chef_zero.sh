#!/bin/bash -x

apt-get update
apt-get -y install git ruby1.9.1 ruby1.9.1-dev build-essential curl

gem install chef-zero

chef-zero -H 0.0.0.0 &

if [ ! -f /home/vagrant/.chef/knife.db ]
then
  echo "Preparing to install chef client..."
  mkdir -p /home/vagrant/.chef
  cp /vagrant/cert.pem /home/vagrant/.chef/admin.pem 

cat<<KNIFE > /home/vagrant/.chef/knife.rb
log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/vagrant/cert.pem'
validation_client_name   'chef-validator'
validation_key           '/vagrant/cert.pem'
chef_server_url          'http://127.0.0.1:8889'
cache_type               'BasicFile'
cache_options( :path => '/home/vagrant/.chef/checksums' )
KNIFE

  chown vagrant. /home/vagrant/.chef/*

  echo "Chef server installed!!\nNow let us configure up the cookbooks."
#  cd /vagrant/chef-cookbooks
#  knife cookbook upload -o cookbooks --all
#  knife role from file roles/*.rb
#  knife environment from file /vagrant/extras/environment_vagrant.json
#  knife node from file /vagrant/extras/allinone_node.json
#  knife node from file /vagrant/extras/single_controller_node.json
#  knife node from file /vagrant/extras/single_compute_node.json


else 
  echo "chef server already installed!"
fi