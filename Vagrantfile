# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.vm.define "VagrantJenkins" do |jenkins|
    jenkins.vm.box = "VagrantJenkins"
    jenkins.vm.hostname = 'VagrantJenkins'
    #jenkins.vm.box_url = "/home/aliaksei_ulitsin/vagrant/Soft/sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
    jenkins.vm.box_url = "https://atlas.hashicorp.com/sbeliakou/boxes/centos-7.3-x86_64-minimal"
    jenkins.vm.network :private_network, ip: "192.168.56.13"
    config.vm.synced_folder "/home/aliaksei_ulitsin/vagrant/tmpvagrant/master_jenkins", "/opt/jenkins/"
    jenkins.vm.provider "virtualbox" do |vb|
    	vb.memory = "4096"
     	vb.name = "jenkins1"
    end
    
    config.vm.provision "shell", inline: <<-SHELL

	yum install java-1.8.0-openjdk.x86_64 -y;
	yum install -y vim;

   #Nginx 
	yum -y install nginx
	sed -i 's| location / {| location / {proxy_pass http://localhost:8080;|' /etc/nginx/nginx.conf;
	sleep 3;
	systemctl start nginx;
	systemctl enable nginx;
	echo "127.0.0.1 jenkins" >> /etc/hosts


  #Jenkins
	groupadd jenkins;
	useradd -g jenkins -c "jenkins user" jenkins;
	echo jenkins | passwd jenkins --stdin;
	mkdir /opt/jenkins;
	mkdir /opt/jenkins/bin;
	mkdir /opt/jenkins/master;
	chown -R jenkins:jenkins /opt/jenkins;
	#cp /jenkins1/jenkins.war /opt/jenkins/bin/jenkins.war;
	wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war;
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

