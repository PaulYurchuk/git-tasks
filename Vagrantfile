Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "jenkins"
    jenkins.vm.hostname = 'jenkins'
    jenkins.vm.box_url = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"

    jenkins.vm.network :private_network, ip: "192.168.56.101"

    jenkins.vm.synced_folder "share/", "/share"
        
    jenkins.vm.provider :virtualbox do |v|
      v.memory = "2048"
      v.name = "jenkinsVM"
    end
    jenkins.vm.provision "shell", inline: <<-SHELL
    sudo su
    yum -y install java-devel
    mkdir /opt/jenkins/ /opt/jenkins/master /opt/jenkins/bin
    useradd jenkins
    chown -R jenkins /opt/jenkins
    SHELL
  end
end
