Stand up Vagrant Boxes
======================

Clone recursively to get all openstack cookbooks
------------------------------------------------

`git clone --recursive git@github.com:paulczar/vagrant-openstack.git`  

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

Install Openstack
-----------------

vagrant ssh allinone
/vagrant/extras/install_openstack.sh


check if it worked
------------------

https://33.33.33.60
username: admin
password: secrete

Notes
=====

* provision scripts are stupidly idempotent ...  they assume if knife.rb exists that everything is rosy.

ToDo
====

* creating instances in horizon fails ... work out why.
