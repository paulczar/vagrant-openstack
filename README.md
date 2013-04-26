=Initial Chef Server=

==Chef Server==

    vagrant up chef
    vagrant ssh chef
    knife client list
        chef-validator
        chef-webui
        vagrant

==Chef Client==
    vagrant up allinone
    vagrant ssh allinone
    knife client list
        chef-validator
        chef-webui
        vagrant



=Openstack=

==Install Cookbooks==

    sudo apt-get -y install git
    git submodule update --init --recursive git@github.com:opscode-cookbooks/chef-server.git

    vagrant ssh chef

    cd chef-cookbooks
    knife cookbook upload -o cookbooks --all
    knife role from file roles/*.rb
    knife environment from file /vagrant/environment_vagrant.json
    knife node run_list add allinone 'role[allinone]'
    knife node edit allinone -e vi
    exit

    vagrant ssh allinone
    # sudo gem install right_aws --no-ri --no-rdoc
    sudo chef-client

==check if it worked==

https://chef
username: admin
password: secrete
