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

yum install nginx -y;
sed -i '38d;39d;40d;41d;42d;43d;44d;45d;46d;47d;48d;49d;50d;51d;52d;53d;54d;55d;56d;57d' /etc/nginx/nginx.conf;

touch /etc/nginx/conf.d/newser.conf;
echo "server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
	proxy_pass http://127.0.0.1:8080;

        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    } " >>/etc/nginx/conf.d/newser.conf;

systemctl enable nginx;
systemctl start nginx;

echo "127.0.0.1 jenkins" >> /etc/hosts


#---Jenkins----
groupadd jenkins
useradd -g jenkins -c "jenkins user" jenkins
echo jenkins | passwd jenkins --stdin
mkdir /opt/jenkins
mkdir /opt/jenkins/bin
mkdir /opt/jenkins/master
chown -R jenkins:jenkins /opt/jenkins
#cp /vagrant/jenkins.war /opt/jenkins/bin/jenkins.war
wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war


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
ExecStart=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/bin/java -jar /opt/jenkins/bin/jenkins.war
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
