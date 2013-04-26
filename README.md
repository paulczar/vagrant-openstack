Stand up Vagrant Boxes
======================

Make sure cookbook submodules are loaded
----------------------------------------

    git submodule update --init --recursive git@github.com:opscode-cookbooks/chef-server.git


Chef Server
-----------

    vagrant up chef
    vagrant ssh chef
    knife client list
        chef-validator
        chef-webui
        vagrant

Chef Client
-----------

    vagrant up allinone
    vagrant ssh allinone
    knife client list
        chef-validator
        chef-webui
        vagrant



Openstack
=========

Install Cookbooks
-----------------

vagrant ssh allinone
extras/install_openstack.sh


check if it worked
------------------

https://chef
username: admin
password: secrete

ToDo
====

* make install scripts idempotent