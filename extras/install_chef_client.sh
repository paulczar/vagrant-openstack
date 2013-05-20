#!/bin/bash 

if [ ! -f /home/vagrant/.chef/knife.db ]
then
  echo "Preparing to install chef client..."
  echo 33.33.33.50 chef >> /etc/hosts
  apt-get -y install curl git links
  curl --silent -L http://www.opscode.com/chef/install.sh | bash
  mkdir -p /etc/chef
  cp /vagrant/chef/chef-validator.pem /etc/chef/validation.pem
  mkdir -p /home/vagrant/.chef
  cp /vagrant/chef/*.pem /home/vagrant/.chef/

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

  chown vagrant. /vagrant/chef/*
  chown vagrant. /home/vagrant/.chef/*

# normally you wouldn't specify the version here as it should match up ...  doing this to avoid a reboot.
apt-get -y install linux-headers-3.2.0-23-generic
apt-get -y install vlan bridge-utils
apt-get -y install quantum-server quantum-plugin-openvswitch openvswitch-switch openvswitch-datapath-dkms 
apt-get -y install quantum-plugin-openvswitch-agent quantum-dhcp-agent quantum-l3-agent
/etc/init.d/openvswitch-switch start

# br-int will be used for VM integration
ovs-vsctl add-br br-int

#br-ex is used to make to VM accessible from the internet
ovs-vsctl add-br br-ex
ovs-vsctl add-port br-ex eth2

chef-client

echo "restart all the services for shits n giggles..."
cd /etc/init.d/; for i in $(ls nova-*); do sudo service $i restart; done

echo "check if all services are running..."
sudo nova-manage service list

echo "##################################"
echo "#     Openstack Installed        #"
echo "#   visit https://33.33.33.60    #"
echo "#   default username: admin      #"
echo "#   default password: secrete    #"
echo "##################################"

# seems to help clear up some weirdness where it tries to launch instances 
# using KVM rather than the Qemu as set in the environment JSON file.
restart nova-compute


else 
  echo "chef Client already installed!"
  chef-client  
fi
