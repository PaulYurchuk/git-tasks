# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.vm.define "VagrantJenkins" do |jenkins|
    jenkins.vm.box = "VagrantJenkins"
    jenkins.vm.hostname = 'VagrantJenkins'
    jenkins.vm.box = "/home/aliaksei_ulitsin/vagrant/Soft/sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
#    jenkins.vm.box_url = "https://atlas.hashicorp.com/sbeliakou/boxes/centos-7.3-x86_64-minimal"
    jenkins.vm.network :private_network, ip: "192.168.56.13"
#    config.vm.synced_folder "/home/aliaksei_ulitsin/vagrant/jenkins/jenkins_master", "/opt/jenkins/master", type: "rsync", mount_options: ["dmode=777,fmode=777"]
#    config.vm.synced_folder "/home/aliaksei_ulitsin/vagrant/jenkins/git-tasks/opt_jenkins/", "/opt/jenkins/", type: "rsync"
    config.vm.synced_folder "/home/aliaksei_ulitsin/vagrant/jenkins/git-tasks/opt_jenkins/", "/opt/jenkins/"


    jenkins.vm.provider "virtualbox" do |vb|
    	vb.memory = "4096"
     	vb.name = "VagrantJenkins"
    end
    
    config.vm.provision "shell", inline: <<-SHELL

	yum install java-1.8.0-openjdk.x86_64 -y;
	yum install -y vim;

   #Nginx 
	yum -y install nginx
#	ed -i 's| location / {| location / {proxy_pass http://192.168.56.13:8080; proxy_redirect http://127.0.0.1:8080 http://jenkins; |' /etc/nginx/nginx.conf;
 	ed -i 's| location / {| location / {proxy_pass http://192.168.56.13; proxy_redirect http://192.168.56.13 http://jenkins; |' /etc/nginx/nginx.conf;

#	ed -i 's| location / {| location / {proxy_pass http://localhost:8080;|' /etc/nginx/nginx.conf;
#       ed -i 's| location / {| location / {proxy_pass http://192.168.56.13:8080;|' /etc/nginx/nginx.conf;
	sleep 3;
	systemctl start nginx;
	systemctl enable nginx;
	echo "127.0.0.1 jenkins" >> /etc/hosts

#	yum install epel-release -y
#	yum install nginx -y 
#	cat > /etc/nginx/conf.d/lb.conf <<-EOF
#	server {
#		listen 80;
#		server_name jenkins 192.168.56.13;
#		location / {
#			sendfile off;
#			proxy_pass http://localhost:8080;
#			proxy_redirect default;
#			proxy_http_version 1.1;
#				}
#		}
#	EOF
	systemctl enable nginx
	systemctl start nginx


  #Jenkins
	groupadd jenkins;
	useradd -g jenkins -c "jenkins user" jenkins;
	echo jenkins | passwd jenkins --stdin;
	mkdir /opt/jenkins;
	mkdir /opt/jenkins/bin;
	mkdir /opt/jenkins/master;
#	chown -R vagrant:vagrant /opt/jenkins;
	chown -R jenkins:jenkins /opt/jenkins;
        wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war
#        cp /home/aliaksei_ulitsin/vagrant/jenkins/git-tasks/jenkins.war /opt/jenkins/bin;

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
		Restart=alway
		Uset=jenkins
		RestartSec=20

	[Install]
		WantedBy=multi-user.target " >> /etc/systemd/system/jenkins.service
	        systemctl daemon-reload
		systemctl start jenkins.service
		systemctl enable jenkins.service
	

echo "$(cat /opt/jenkins/master/secrets/initialAdminPassword)"
SHELL
end
end
