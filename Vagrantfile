Vagrant.configure("2") do |config|
  config.vm.box = "sbeliakou/centos"
    config.vm.hostname = "nginx"
    config.vm.network "private_network", ip: "192.168.56.10"
    config.vm.provider "virtualbox" do |vbox_httpd|
      vbox_httpd.memory = 1024
      vbox_httpd.cpus = 1
    end
    config.vm.provision "shell", path: "nginx.sh"
end