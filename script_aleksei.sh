#! /bin/bash
mkdir -p /opt/jenkins/bin
mkdir /opt/jenkins/master
#wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war
yum install java -y 

useradd jenkins
usermod -p $(echo root | openssl passwd -1 -stdin) jenkins
usermod jenkins -G wheel

chown -R jenkins /opt/jenkins/*

echo "export JENKINS_HOME=/opt/jenkins/master" >>/etc/environment	
echo "export JENKINS_DIR=/opt/jenkins/bin" >>/etc/environment	
export JENKINS_HOME=/opt/jenkins/master	
export JENKINS_DIR=/opt/jenkins/bin

cp /home/vagrant/jenkins.war /opt/jenkins/bin
cp /home/vagrant/jenkins.service /etc/systemd/system
systemctl enable jenkins.service
systemctl start jenkins.service

