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

config.vm.provision "shell", inline: <<-SHELL

yum -y install nginx


cat > /etc/systemd/system/jenkins.service <<- EOM

# Systemd unit file for jenkins
[Unit]
Description=Jenkins Server Daemon
After=syslog.target network.target

[Service]
ExecStart/etc/systemd/system/jenkins.service
Restart=always
Type=forking

Environment=JENKINS_HOME=/opt/jenkins/master
Environment=JENKINS_DIR=/opt/jenkins/bin

[Install]
WantedBy=multi-user.target

EOM

systemctl daemon-reload
systemctl enable jenkins
systemctl enable nginx
systemctl start nginx
 
SHELL

end
