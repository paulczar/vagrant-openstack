#!/bin/bash -x 

cd /vagrant/chef-cookbooks
knife cookbook upload -o cookbooks --all
knife role from file roles/*.rb
knife environment from file /vagrant/extras/environment_vagrant.json
knife node run_list add allinone 'role[allinone]'
knife node from file /vagrant/extras/allinone_node.json

# sudo gem install right_aws --no-ri --no-rdoc
# multiple runs just to be sure, had some weird issues on first run.
# run once
sudo chef-client
# run twice
sudo chef-client
# run thrice 
sudo chef-client

# restart all the services for shits n giggles
cd /etc/init.d/; for i in $(ls nova-*); do sudo service $i restart; done

# check if all services are running
sudo nova-manage service list