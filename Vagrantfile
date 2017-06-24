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
  config.vm.provision "shell", inline: <<-SHELL

yum -y install nginx
rm -rf /etc/nginx/nginx.conf

cat > /etc/nginx/nginx.conf <<- EOM

user nginx;
worker_processes 1;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    access_log  /var/log/nginx/access.log;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;
    ignore_invalid_headers off;
server {
        listen       80 default_server;
        server_name  jenkins;
        root         /usr/share/nginx/html;
      
location / {
           proxy_pass http://localhost:8080;
                      }   
     
error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;      
        }
}
}

yum -y install java

group add jenkins
useradd jenkins -d /opt/jenkins
mkdir -p /opt/jenkins/bin
cp /vagrant/jenkins.war /opt/jenkins/bin/
chown -R jenkins:jenkins /opt/jenkins
chmod -R 775 /opt/jenkins


SHELL

end

