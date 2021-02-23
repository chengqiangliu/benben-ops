# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

boxes = [
    {
        :name => "hadoop101",
        :eth1 => "192.168.10.101",
        :mem => "1024",
        :cpu => "1"
    },
    {
        :name => "hadoop102",
        :eth1 => "192.168.10.102",
        :mem => "1024",
        :cpu => "1"
    },
    {
        :name => "hadoop103",
        :eth1 => "192.168.10.103",
        :mem => "1024",
        :cpu => "1"
    }
]

Vagrant.configure("2") do |config|
  # 设置虚拟机的Box
  config.vm.box = "centos/7"

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|

      # 设置虚拟机的主机名
      config.vm.hostname = opts[:name]

#       config.vm.provider "vmware_fusion" do |v|
#         v.vmx["memsize"] = opts[:mem]
#         v.vmx["numvcpus"] = opts[:cpu]
#       end

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
      
      # 设置虚拟机的IP
      config.vm.network :private_network, ip: opts[:eth1]
    end
  end

 # 使用shell脚本进行软件安装和配置
 # Generic initialization
 config.vm.provision "shell", path: "src/scripts/start.sh"

 # copy required tar for installation
 config.vm.provision "file", source: "src/tar", destination: "/tmp/"

 # java development kit 8 installation
 config.vm.provision "shell", path: "src/scripts/jdk8_install.sh"

 # java development Scala 2.12.13 installation
 config.vm.provision "shell", path: "src/scripts/scala212_install.sh"

 # Closing provisioning
 config.vm.provision "shell", path: "src/scripts/closure.sh"
end