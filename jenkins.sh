#!/bin/bash

#Making user jenkins
groupadd  jenkins;
useradd -g jenkins jenkins;

#Installing JDK 1.8.0 and some tools for work
yum install -y vim;
yum install -y net-tools;
yum install -y java-1.8.0-openjdk-devel.x86_64;

#Prepare env
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/;
echo "/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/" >> /etc/environment;

#Mkdir for Jenkins
mkdir -p /opt/jenkins/bin;
mkdir -p /opt/jenkins/master;
cp /share1/jenkins.war /opt/jenkins/bin/;
cp /vagrant/start.sh /opt/jenkins/bin/;

#UNIT script for jenkins
touch /etc/systemd/system/jenkins.service;
cat >/etc/systemd/system/jenkins.service << EOL
#Systemd unit file for jenkins
[Unit]
Description=Jenkins
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/
Environment=JENKINS_HOME=/opt/jenkins/master
Environment=JENKINS_DIR=/opt/jenkins/bin
ExecStart=/opt/jenkins/bin/start.sh
ExecStop=/bin/kill -15 $MAINPID
User=jenkins
Group=jenkins
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target 
EOL
systemctl daemon-reload;
sleep 2;
systemctl enable jenkins;
sleep 2;
chown -R jenkins:jenkins /opt/jenkins;
systemctl start jenkins;
ps -ef | grep java;
sleep 5;


echo "=========================END OF FILE===========================";
