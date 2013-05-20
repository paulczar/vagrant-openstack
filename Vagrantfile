Vagrant::Config.run do |config|

  config.vm.define :chef do |chef_config|
    # TODO REMOVE THIS WHEN WE FORCE SMP MODE IN ERCHEF
    #chef_config.vm.customize ["modifyvm", :id, "--cpus", 2]
    chef_config.vm.customize ["modifyvm", :id, "--memory", 1024]
    chef_config.vm.host_name = "chef"
    chef_config.vm.box = "precise64"
    chef_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
    chef_config.vm.network :hostonly, "33.33.33.50"
    chef_config.ssh.max_tries = 40
    chef_config.ssh.timeout   = 120
    chef_config.ssh.forward_agent = true
    chef_config.vm.provision :shell, :path => "extras/install_chef_server.sh"
  end

  config.vm.define :allinone do |allinone_config|
    allinone_config.vm.host_name = "allinone"
    allinone_config.vm.customize ["modifyvm", :id, "--cpus", 2]
    allinone_config.vm.customize ["modifyvm", :id, "--memory", 2048]
    allinone_config.vm.box = "precise64"
    allinone_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"
    allinone_config.vm.network :hostonly, "33.33.33.60"
    allinone_config.vm.network :hostonly, "10.10.100.1"
    allinone_config.vm.network :hostonly, "172.16.101.1"
    allinone_config.vm.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    allinone_config.vm.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    allinone_config.ssh.max_tries = 40
    allinone_config.ssh.timeout   = 120
    allinone_config.ssh.forward_agent = true
    allinone_config.vm.provision :shell, :path => "extras/install_chef_client.sh"
    allinone_config.vm.provision :shell, :inline => "ifconfig eth2 promisc"
  end

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

