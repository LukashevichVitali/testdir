#I don't use firewalld for ports, because it is disabled by default in this vagrant box. 
#I use 1 cpu, becouse default is 2.
Vagrant.configure("2") do |config|
  config.vm.box = "sbeliakou/centos"
  config.vm.define "httpd" do |httpd|
    httpd.vm.hostname = "httpd"
    httpd.vm.network "private_network", ip: "192.168.56.10"
    httpd.vm.provider "virtualbox" do |vbox_httpd|
      vbox_httpd.memory = 1024
      vbox_httpd.cpus = 1
    end
    httpd.vm.provision "shell", path: "httpd.sh"
  end

  (1..2).each do |i|
    config.vm.define "tomcat-#{i}" do |tomcat|
      tomcat.vm.hostname = "tomcat-#{i}"
      tomcat.vm.network "private_network", ip: "192.168.56.#{i + 10}"
      tomcat.vm.provider "virtualbox" do |vbox_tomcat|
        vbox_tomcat.memory = 2048
        vbox_tomcat.cpus = 1
      end
      tomcat.vm.provision "shell", path: "tomcat.sh"
    end
  end
end