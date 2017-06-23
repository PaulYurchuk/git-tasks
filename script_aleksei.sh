#! /bin/bash
mkdir -p /opt/jenkins/bin
cp /home/vagrant/jenkins.war /optjenkins/bin

useradd jenkins
usermod -p $(echo root | openssl passwd -1 -stdin) jenkins
usermod jenkins -G wheel