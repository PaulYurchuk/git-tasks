# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.vm.box = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
    config.vm.hostname = "jenkins"
    config.vm.network "private_network", ip: "192.168.50.10"
    config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.name = "jenkins"
end

config.vm.post_up_message = "VM has been successfully created"

#config.vm.provision "shell", inline: <<-SHELL


#SHELL

end
