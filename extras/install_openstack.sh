#!/bin/bash -x 

cd /vagrant/chef-cookbooks
knife cookbook upload -o cookbooks --all
knife role from file roles/*.rb
knife environment from file /vagrant/extras/environment_vagrant.json
knife node run_list add allinone 'role[allinone]'
knife node from file /vagrant/extras/allinone_node.json

# sudo gem install right_aws --no-ri --no-rdoc
sudo chef-client
