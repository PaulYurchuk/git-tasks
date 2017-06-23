Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
	jenkins.vm.box = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
	jenkins.vm.network "private_network", ip: "192.168.56.50"
	jenkins.vm.hostname = "jenkins"
	jenkins.vm.provider :virtualbox do |v|
	v.customize ["modifyvm", :id, "--name", "jenkins"]
	jenkins.vm.provision "shell", inline: <<-SHELL
		yum -y install java-1.8.0-openjdk-devel



		touch /etc/systemd/system/jenkins.service
		cat > /etc/systemd/system/jenkins.service << EOL
		[Unit]
		Description=Jenkins Daemon
		[Service]
		ExecStart=java -jar /opt/jenkins/jenkins.war
		User=jenkins
		[Install]
		WantedBy=multi-user.target
		EOL
		systemctl daemon-reload
		systemctl enable jenkins.service
		systemctl start jenkins.service
	SHELL
  end
end
