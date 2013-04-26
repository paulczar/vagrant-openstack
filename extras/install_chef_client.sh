#!/bin/bash -x

echo 33.33.33.50 chef >> /etc/hosts
apt-get -y install curl git links
curl --silent -L http://www.opscode.com/chef/install.sh | bash
mkdir -p /etc/chef
cp /vagrant/.chef/chef-validator.pem /etc/chef/validation.pem
mkdir -p /home/vagrant/.chef
cp /vagrant/.chef/* /home/vagrant/.chef/

cat<<CHEF > /etc/chef/client.rb
    log_level        :info
    log_location     STDOUT
    chef_server_url  'https://33.33.33.50/'
    validation_client_name 'chef-validator'
CHEF


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

chef-client
