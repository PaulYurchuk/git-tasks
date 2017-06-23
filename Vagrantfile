# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
   config.vm.box = "jenkins"
   config.vm.box_url = "centos73-min.box"
   config.vm.hostname = "jenkins"
   config.vm.network "private_network", ip: "192.168.56.10"
   config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
   end

   config.vm.provision "shell", inline: <<-SHELL
     useradd jenkins
     mkdir -p /opt/jenkins/bin
     mkdir -p /opt/jenkins/master
     chown jenkins:jenkins /opt/jenkins/bin
     chown jenkins:jenkins /opt/jenkins/master
     chmod 775 /opt/jenkins/bin
     chmod 775 /opt/jenkins/master
     cp /vagrant/jenkins.war /opt/jenkins/bin
     yum localinstall /vagrant/jdk-8u131-linux-x64.rpm -y
    SHELL
end
