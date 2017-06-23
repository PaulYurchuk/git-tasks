# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "jenkins"
    jenkins.vm.hostname = 'jenkins'
    jenkins.vm.box_url = "/home/student/git_jenkins/sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"

    jenkins.vm.network :private_network, ip: "192.168.56.23"

    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.name = "jenkins"
    end
config.vm.provision "shell", inline: <<-SHELL
yum install java-1.8.0-openjdk.x86_64 -y



#---Jenkins----
groupadd jenkins
useradd -g jenkins -c "jenkins user" jenkins
echo jenkins | passwd jenkins --stdin
mkdir /opt/jenkins
mkdir /opt/jenkins/bin
mkdir /opt/jenkins/master
chown -R jenkins:jenkins /opt/jenkins
cp /vagrant/jenkins.war /opt/jenkins/bin/jenkins.war



#-- Creating systemd .service script for JENKINS
touch /etc/systemd/system/jenkins.service
echo "
[Unit]
Description=Jenkins
After=network.target
Requires=network.target

[Service]
Type=simple
Environment=JENKINS_HOME=/opt/jenkins/master
Environment=JENKINS_DIR=/opt/jenkins/bin
ExecStart=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/bin/java -jar $JENKINS_DIR/jenkins.war
Restart=always
User=jenkins
RestartSec=20

[Install]
WantedBy=multi-user.target " >> /etc/systemd/system/jenkins.service

systemctl enable jenkins.service
systemctl start jenkins
SHELL
end
end
