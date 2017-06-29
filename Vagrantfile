# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |conf|
 conf.vm.define "jenkins_master" do |jenkins|
  jenkins.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
  jenkins.vm.hostname = "jenkins-a-d"
  jenkins.vm.network "private_network", ip: "192.168.123.45"
  jenkins.vm.network "public_network", bridge: "enp8s0"
  jenkins.vm.provider "virtualbox" do |vb|
   vb.memory = "1024"
   vb.name = "jenkins_master"
  end
  jenkins.vm.post_up_message = "jenkins vm is loaded"
  jenkins.vm.provision "file", source: "./jenkins.service", destination: "jenkins.service"
  jenkins.vm.provision "file", source: "~/Documents/vagrant/jenkins.war", destination: "jenkins.war"
  jenkins.vm.synced_folder "master/", "/opt/jenkins/master", mount_options: ['dmode=777', 'fmode=777']
  jenkins.vm.provision "shell", path: "script_daniil.sh" 
  jenkins.vm.provision "shell", path: "script_aleksei.sh"
 end
 conf.vm.define "jenkins_slave1" do |jenkins|
  jenkins.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
  jenkins.vm.hostname = "jenkins-a-d"
  jenkins.vm.network "private_network", ip: "192.168.123.46"
  jenkins.vm.network "public_network", bridge: "enp8s0"
  jenkins.vm.provider "virtualbox" do |vb|
   vb.memory = "1024"
   vb.name = "jenkins_slave1"
  end
  jenkins.vm.post_up_message = "jenkins vm is loaded"
  jenkins.vm.provision "file", source: "./jenkins.service", destination: "jenkins.service"
  jenkins.vm.provision "file", source: "~/Documents/vagrant/jenkins.war", destination: "jenkins.war"
  jenkins.vm.synced_folder "slave1/", "/opt/jenkins/master", mount_options: ['dmode=777', 'fmode=777']
  jenkins.vm.provision "shell", path: "script_daniil.sh" 
  jenkins.vm.provision "shell", path: "script_aleksei.sh"
 end
 conf.vm.define "jenkins_slave2" do |jenkins|
  jenkins.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
  jenkins.vm.hostname = "jenkins-a-d"
  jenkins.vm.network "private_network", ip: "192.168.123.47"
  jenkins.vm.network "public_network", bridge: "enp8s0"
  jenkins.vm.provider "virtualbox" do |vb|
   vb.memory = "1024"
   vb.name = "jenkins_slave2"
  end
  jenkins.vm.post_up_message = "jenkins vm is loaded"
  jenkins.vm.provision "file", source: "./jenkins.service", destination: "jenkins.service"
  jenkins.vm.provision "file", source: "~/Documents/vagrant/jenkins.war", destination: "jenkins.war"
  jenkins.vm.synced_folder "slave2/", "/opt/jenkins/master", mount_options: ['dmode=777', 'fmode=777']
  jenkins.vm.provision "shell", path: "script_daniil.sh" 
  jenkins.vm.provision "shell", path: "script_aleksei.sh"
 end
end
