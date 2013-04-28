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
  allinone_config.vm.customize ["modifyvm", :id, "--memory", 4096]
  allinone_config.vm.box = "precise64"
  allinone_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box"

  allinone_config.vm.network :hostonly, "33.33.33.60"
  allinone_config.vm.network :hostonly, "10.10.100.60"
  allinone_config.vm.network :hostonly, "172.16.101.60"

  allinone_config.vm.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
  allinone_config.vm.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]


  allinone_config.ssh.max_tries = 40
  allinone_config.ssh.timeout   = 120

  # Enable SSH agent forwarding for git clones
  allinone_config.ssh.forward_agent = true
  allinone_config.vm.provision :shell, :path => "extras/install_chef_client.sh"
 end

end

