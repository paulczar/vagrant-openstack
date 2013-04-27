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

Install Cookbooks
-----------------

vagrant ssh allinone
/vagrant/extras/install_openstack.sh


check if it worked
------------------

https://chef
username: admin
password: secrete

ToDo
====

* make install scripts idempotent