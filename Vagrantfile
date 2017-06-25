# -*- mode: ruby -*-
# vi: set ft=ruby :

 
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

config.vm.define "newjenkins" do |newjenkins|
	newjenkins.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
	newjenkins.vm.hostname = "newjenkins"
	newjenkins.vm.network "private_network", ip: "192.168.56.102"
	newjenkins.vm.network :forwarded_port, guest: 80, host: 8081, auto_correct: true
	newjenkins.vm.network :forwarded_port, guest: 8080, host: 8091, auto_correct: true
	newjenkins.vm.network :forwarded_port, guest: 22, host: 2221, auto_correct: true
	newjenkins.vm.provider "virtualbox" do |vb|
    		vb.memory = "4096"
    		vb.name = "newjenkins"
   	end
	newjenkins.vm.post_up_message = "Jenkins VM is ready to work"
	newjenkins.vm.provision "shell", inline: <<-SHELL
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
	wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war;
	touch /opt/jenkins/bin/start.sh;
	mkdir -p /log;
	
	#Fulling of custom startupscript
	cat >/opt/jenkins/bin/start.sh << STFL
	LOG_FILE=/log/jenkins.log
	JENKINS_RUN="java -jar /opt/jenkins/bin/jenkins.war"
	exec 1>>${LOG_FILE}
	exec 2>>${LOG_FILE}
	nohup $JENKINS_RUN >> $LOG_FILE &
STFL
	chmod +x /opt/jenkins/bin/start.sh
	
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
	chown -R jenkins:jenkins /log;
	systemctl start jenkins;
	ps -ef | grep java;
	sleep 5;


	echo "=========================Jenkins has started===========================";

	#Nginx installation and enabling
	yum -y install nginx
	sed -i 's/ location \/ {/ location \/ {proxy_pass http:\/\/192.168.56.102:8080;/' /etc/nginx/nginx.conf;
	sleep 3;
	systemctl start nginx;
	systemctl enable nginx;
	echo "=========================NGINX has started===========================";

	SHELL
end
end 
