OpenStack on Vagrant
====================

About
-----

This is an attempt to make a simple to install openstack cluster for testing and learning on.

I chose to use the rcbops (rackspace) recipes for this as they ship some excellent roles which makes it very easy to use.

Notes on Quantum
----------------

boy what a mess.   had to install a bunch of packages ( this might help - https://github.com/att-cloud/cookbook-openvswitch ) in the
install_chef_client.sh script.   this'll only work right now in the allinone type.   once up I had to run manual commands to create network etc
under quantum.  see this gist - https://gist.github.com/paulczar/5610433

was able to launch 2 cirros instances on the created network and they could ping eachother.  a start i guess.


Download Project
----------------

`git clone --recursive git@github.com:paulczar/vagrant-openstack.git`  

Install Chef Server
-------------------

_first run may be slow as it has to download a large .deb for chef_

    vagrant up chef

* may as well log in and confirm it worked...


    vagrant ssh chef
    knife client list
        chef-validator
        chef-webui
        vagrant

Option 1:  All-in-one Openstack node
------------------------------------

    vagrant up allinone

_this will take quite some time..._

    vagrant ssh allinone
    knife client list
        chef-validator
        chef-webui
        vagrant

Option 2:  Seperate Controller and Compute Openstack nodes
-----------------------------------------------------------

_will not work currently_

    vagrant up single_controller
    vagrant up single_compute



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

* make provision scripts nicer
* test with quantum
* test against opscode recipes,  att-cloud recipes.
* grizzly!  rowr!

License and Author
==================

Author:: Paul Czarkowski ( paul@paulcz.net )

Copyright 2013, Paul Czarkowski

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

`http://www.apache.org/licenses/LICENSE-2.0`

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

Chef Cookbooks used unchanged from `https://github.com/rcbops/chef-cookbooks`