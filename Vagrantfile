# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
   config.vm.box = "sbeliakou/centos-7.3-x86_64-minimal"
   #config.vm.box = "centos73-min.box"
   config.vm.box_url = "https://atlas.hashicorp.com/sbeliakou/boxes/centos-7.3-x86_64-minimal"
   #config.vm.box_url = "centos73-min.box"
   config.vm.hostname = "jenkins"
   config.vm.network "private_network", ip: "192.168.56.10"
   config.vm.provider "virtualbox" do |vb|
   config.vm.synced_folder "./jenkins_home", "/opt/jenkins/master", create: true, mount_options: ["dmode=777,fmode=777"]
    vb.memory = "2048"
   end
   config.vm.provision "shell", inline: <<-SHELL

	useradd jenkins
	mkdir -p /opt/jenkins/bin
	wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war
	#cp /vagrant/jenkins.war /opt/jenkins/bin 
	chown -R jenkins:jenkins /opt/jenkins
	chmod -R 775 /opt/jenkins
	yum install java-1.8.0-openjdk-devel -y
	
	# jenkins config
	cat > /usr/lib/systemd/system/jenkins.service <<-EOF
	[Unit]
	Description=Jenkins
	After=network-network.target remote-fs.target nss-lookup.target
	[Service]
	Type=simple
	User=jenkins
	Group=jenkins
	Environment=JENKINS_HOME=/opt/jenkins/master
	Environment=JENKINS_DIR=/opt/jenkins/bin
	ExecStart=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/bin/java -jar /opt/jenkins/bin/jenkins.war
	ExecStop=/bin/kill -s QUIT $MAINPID
	[Install]
	WantedBy=multi-user.target
	EOF
	systemctl daemon-reload
	systemctl enable jenkins
	systemctl start jenkins

	# nginx config
	yum install epel-release -y
	yum install nginx -y 
	cat > /etc/nginx/conf.d/lb.conf <<-EOF
	server {
		listen 80;
		server_name jenkins 192.168.56.10;
		location / {
			sendfile off;
			proxy_pass http://localhost:8080;
			proxy_redirect default;
			proxy_http_version 1.1;
				}
		}
	EOF
	systemctl enable nginx
	systemctl start nginx

	echo "+++++++++++++++++++++++++++++"
	echo "jenkins now available at $(ip address show dev enp0s8 | grep 'inet ' | cut -f2 | awk '{print $2}'):8080"
	echo "or you can add '192.168.56.10 jenkins' to your hosts file and use http://jenkins instead of 'ip:port'"
	echo "+++++++++++++++++++++++++++++"
	sleep 10
	echo "Jenkins unlock password"	
	echo "+++++++++++++++++++++++++++++"	
	echo "$(cat /opt/jenkins/master/secrets/initialAdminPassword)"
	echo "+++++++++++++++++++++++++++++"	

    SHELL
end
