# -*- mode: ruby -*-
# vi: set ft=ruby :

 
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

config.vm.define "newjenkins" do |newjenkins|
	newjenkins.vm.box = "newjenkins"
	newjenkins.vm.hostname = "newjenkins"
	newjenkins.vm.box_url = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
	newjenkins.vm.network "private_network", ip: "192.168.56.102"
	newjenkins.vm.synced_folder "share2/", "/share2", type: "rsync"
	newjenkins.vm.network :forwarded_port, guest: 80, host: 8081, auto_correct: true
	newjenkins.vm.network :forwarded_port, guest: 8080, host: 8091, auto_correct: true
	newjenkins.vm.network :forwarded_port, guest: 22, host: 2221, auto_correct: true
	newjenkins.vm.provider "virtualbox" do |vb|
    		vb.memory = "4096"
    		vb.name = "newjenkins"
   	end
	newjenkins.vm.post_up_message = "Jenkins VM is ready to work"
	newjenkins.vm.provision "shell", path: "./jenkins.sh"
	newjenkins.vm.provision "shell", path: "./nginxinst.sh"
end
end 
