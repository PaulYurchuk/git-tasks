# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
 config.vm.synced_folder ".", "/vagrant", disabled: true

 config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "./../sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
    jenkins.vm.network "private_network", ip: "192.168.121.13"
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
    jenkins.vm.network :forwarded_port, guest: 8080, host: 8090, auto_correct: true
    jenkins.vm.provider "virtualbox" do |v|
	v.memory = "2048"
	v.name = "jenkins"
    end
    jenkins.vm.provision "shell", inline: <<-SHELL
	setenforce 0;
	chattr -i /etc/selinux/config;
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config;
	systemctl stop firewalld
	systemctl disable firewalld
	yum install net-tools nginx -y
	systemctl enable nginx

	###NGINX configuring###
	cd /etc/nginx
	rm -rf nginx.conf
	wget https://github.com/MNT-Lab/git-tasks/blob/yshchanouski-vtarasiuk/nginx.conf -a /var/log/wget.log
	cd /etc/nginx/conf.d
	wget https://github.com/MNT-Lab/git-tasks/blob/yshchanouski-vtarasiuk/server.conf -a /var/log/wget.log
	systemctl start nginx	

	###JAVA install ###
	cd /opt/
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz" -a /var/log/wget.log
	echo "wget command finished - you may chack /var/log/wget.log for results"
	tar xzf jdk-8u131-linux-x64.tar.gz
	cd /opt/jdk1.8.0_131/
	alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2
	alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_131/bin/jar 2
	alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_131/bin/javac 2
	alternatives --set jar /opt/jdk1.8.0_131/bin/jar
	alternatives --set javac /opt/jdk1.8.0_131/bin/javac
	echo "export JAVA_HOME=/opt/jdk1.8.0_131" >>/etc/environment
	echo "export JRE_HOME=/opt/jdk1.8.0_131/jre" >>/etc/environment
	echo "export PATH=$PATH:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin" >>/etc/environment
	######
	
    SHELL
  end
end
