# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
 config.vm.define "Jenkins" do |Jenkins| 
 jenkins.vm.box = "setup"
 jenkins.vm.hostname = "pyurchuk-ndolya.jenkins"
 jenkins.vm.box_url = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"


jenkins.vm.network "private_network", ip: "192.168.56.100"
jenkins.vm.network "public_network", bridge: "enp1s0"

jenkins.vm.provider :virtualbox do |vb|
vb.memory = "4096"
vb.name = "jenkins"
end

config.vm.post_up_message = "VM has been successfully created"

config.vm.provision "shell", inline: <<-SHELL


sudo yum install nginx

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

 
SHELL

end
