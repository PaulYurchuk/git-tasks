Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"
    jenkins.vm.hostname = 'jenkins'
    jenkins.vm.box_url = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"

    jenkins.vm.network :private_network, ip: "192.168.56.23"

    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.name = "jenkins"
    end
  config.vm.provision "shell", path: "nginx.sh"
  end
end
