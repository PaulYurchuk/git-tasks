#! /bin/bash
mkdir -p /opt/jenkins/bin
mkdir /opt/jenkins/master
cp /home/vagrant/jenkins.war /opt/jenkins/bin

useradd jenkins
usermod -p $(echo root | openssl passwd -1 -stdin) jenkins
usermod jenkins -G wheel


export JENKINS_HOME=/opt/jenkins/master

