#!/bin/bash
groupadd -m jenkins;
useradd -g jenkins jenkins;
su - jenkins;
#yum install -y nginx;
#sleep 3;
#sed -i  's/ location \/ {/ location \/ {proxy_pass http:\/\/192.168.56.102:8080;/' /etc/nginx/nginx.conf;
#systemctl start nginx;
#systemctl enable nginx;
yum install -y vim;
yum install -y net-tools;
yum install -y java-1.8.0-openjdk-devel.x86_64;
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/;
echo "/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/" >> /etc/environment;
which java;
echo "END OF FILE";
