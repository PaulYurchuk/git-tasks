Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
	jenkins.vm.box = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
	jenkins.vm.box_url = "https://atlas.hashicorp.com/sbeliakou/boxes/centos-7.3-x86_64-minimal"
	jenkins.vm.network "private_network", ip: "192.168.56.50"
	jenkins.vm.hostname = "jenkins"
	jenkins.vm.provider :virtualbox do |v|
		v.customize ["modifyvm", :id, "--name", "jenkins"]
	jenkins.vm.synced_folder "master/", "/opt/jenkins/master", type: "rsync"
	end
	jenkins.vm.provision "shell", inline: <<-SHELL
		yum -y install java-1.8.0-openjdk-devel git nginx unzip 

		wget https://services.gradle.org/distributions/gradle-3.5-bin.zip -p /opt/gradle
		unzip /opt/gradle/gradle-3.5-bin.zip
		mv gradle-3.5 gradle
		ln -s /opt/gradle/bin /usr/bin/gradle

		sed -i '38,57' /etc/nginx/nginx.conf
		cat > /etc/nginx/conf.d/jenkins.conf << 'EOL'
server {
        listen       80;
        server_name  jenkins;
	ignore_invalid_headers off;
	sendfile off;
        location / {
                proxy_pass http://localhost:8080;
		proxy_redirect  http://localhost:8080 http://jenkins;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto "http";
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
}
EOL
		systemctl enable nginx.service
		systemctl start nginx.service

		useradd jenkins
		mkdir /opt/jenkins/bin
		cp /vagrant/jenkins.war /opt/jenkins/bin/

		chown -R jenkins:jenkins /opt/jenkins/
		chmod -R 755 /opt/jenkins/

		wget -P /opt/jenkins/bin/ http://ftp-chi.osuosl.org/pub/jenkins/war-stable/2.60.1/jenkins.war


		cat > /etc/systemd/system/jenkins.service << EOL
[Unit]
Description=Jenkins Daemon
[Service]
Environment=JENKINS_HOME=/opt/jenkins/master
Environment=JENKINS_DIR=/opt/jenkins/bin
ExecStart=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/bin/java -jar /opt/jenkins/bin/jenkins.war
User=jenkins
[Install]
WantedBy=multi-user.target
EOL
		systemctl daemon-reload
		systemctl enable jenkins.service
		systemctl start jenkins.service

		cat /opt/jenkins/master/secrets/initialAdminPassword

	SHELL
  end
end
