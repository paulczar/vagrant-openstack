# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "Use a newer version of Vagrant (1.2.1+)"
end

BOX_NAME = ENV['BOX_NAME'] || "precise64"
BOX_URI = ENV['BOX_URI'] || "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"

Vagrant.configure("2") do |config|

  config.vm.define :chef do |config|
    # TODO REMOVE THIS WHEN WE FORCE SMP MODE IN ERCHEF
    config.vm.hostname = "chef"
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    config.vm.network :private_network, ip: "33.33.33.50"
    config.ssh.max_tries = 40
    config.ssh.timeout   = 120
    config.ssh.forward_agent = true
    config.vm.provision :shell, :path => "extras/install_chef_server.sh"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end

  config.vm.define :allinone do |config|
    config.vm.hostname = "allinone"
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    config.vm.network :private_network, ip: "33.33.33.60"
    config.vm.network :private_network, ip: "10.10.100.60"
    config.vm.network :private_network, ip: "172.16.101.60"
    config.ssh.max_tries = 40
    config.ssh.timeout   = 120
    config.ssh.forward_agent = true
    config.vm.provision :shell, :path => "extras/install_chef_client.sh"
    config.vm.provision :shell, :inline => "ifconfig eth2 promisc"
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--cpus", 2]
        vb.customize ["modifyvm", :id, "--memory", 2048] 
        vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
        vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    end

  end


end

Vagrant::Config.run do |config|


  config.vm.define :single_controller do |single_controller_config|
    single_controller_config.vm.host_name = "single_controller"
    single_controller_config.vm.customize ["modifyvm", :id, "--memory", 512]
    single_controller_config.vm.box = "precise64"
    single_controller_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
    single_controller_config.vm.network :hostonly, "33.33.33.60"
    single_controller_config.ssh.max_tries = 40
    single_controller_config.ssh.timeout   = 120
    single_controller_config.ssh.forward_agent = true
    single_controller_config.vm.provision :shell, :path => "extras/install_chef_client.sh"
  end

  config.vm.define :single_compute do |single_compute_config|
    single_compute_config.vm.host_name = "single_compute"
    single_compute_config.vm.customize ["modifyvm", :id, "--cpus", 2]
    single_compute_config.vm.customize ["modifyvm", :id, "--memory", 2048]
    single_compute_config.vm.box = "precise64"
    single_compute_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
    single_compute_config.vm.network :hostonly, "33.33.33.61"
    single_compute_config.vm.network :hostonly, "10.10.100.61"
    single_compute_config.vm.network :hostonly, "172.16.101.61"
    single_compute_config.vm.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    single_compute_config.vm.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    single_compute_config.ssh.max_tries = 40
    single_compute_config.ssh.timeout   = 120
    single_compute_config.ssh.forward_agent = true
    single_compute_config.vm.provision :shell, :path => "extras/install_chef_client.sh"
    single_compute_config.vm.provision :shell, :inline => "ifconfig eth2 promisc"
  end

end

