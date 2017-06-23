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
     chown -R jenkins:jenkins /opt/jenkins
     chmod -R 775 /opt/jenkins
     cp /vagrant/jenkins.war /opt/jenkins/bin
     yum localinstall /vagrant/jdk-8u131-linux-x64.rpm -y
     cat <<EOF > /usr/lib/systemd/system/jenkins.service
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
#	 systemctl start jenkins # uncomment after disabling SELinux
    SHELL
end
