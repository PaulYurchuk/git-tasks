Vagrant.configure("2") do |config|
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "jenkins"
    jenkins.vm.hostname = 'jenkins'
    jenkins.vm.box_url = "sbeliakou-vagrant-centos-7.3-x86_64-minimal.box"

    jenkins.vm.synced_folder "share/", "/share"
    
    jenkins.vm.provider :virtualbox do |v|
      v.memory = "1024"
      v.name = "jenkinsVM"
    end
  end
end
