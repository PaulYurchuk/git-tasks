# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
   config.vm.box = "jenkins"
   config.vm.box_url = "centos73-min.box"
   config.vm.hostname = "jenkins"
   config.vm.network "private_network", ip: "192.168.56.10"
   config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
   end

   config.vm.provision "shell", inline: <<-SHELL

	useradd jenkins
	mkdir -p /opt/jenkins/bin
	mkdir -p /opt/jenkins/master
	cp /vagrant/jenkins.war /opt/jenkins/bin
	chown -R jenkins:jenkins /opt/jenkins
	chmod -R 775 /opt/jenkins
	yum localinstall /vagrant/jdk-8u131-linux-x64.rpm -y

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
	ExecStart=/usr/java/jdk1.8.0_131/jre/bin/java -jar /opt/jenkins/bin/jenkins.war
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
		server_name jenkins;
		location / {
			sendfile off;
			proxy_pass http://localhost:8080;
			proxy_redirect default;
			proxy_http_version 1.1;
			#part from official jenkins site to fix proxy problems with nginx
			proxy_set_header   Host             $host;
			proxy_set_header   X-Real-IP        $remote_addr;
			proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
			proxy_max_temp_file_size 0;
			#this is the maximum upload size
			client_max_body_size       10m;
			client_body_buffer_size    128k;
			proxy_connect_timeout      90;
			proxy_send_timeout         90;
			proxy_read_timeout         90;
			proxy_buffer_size          4k;
			proxy_buffers              4 32k;
			proxy_busy_buffers_size    64k;
			proxy_temp_file_write_size 64k;
				}
		}
	EOF

	systemctl enable nginx
	systemctl start nginx

    SHELL
end