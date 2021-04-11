# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

server_prefix='vm'
boxes = [
    {
        :name => "#{server_prefix}100",
        :eth1 => "192.168.10.100",
        :mem => "1024",
        :cpu => "1"
    }
]

Vagrant.configure("2") do |config|
  # 设置虚拟机的Box
  config.vm.box = "centos/7"
  config.ssh.insert_key = false

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|

      # 设置虚拟机的主机名
#       config.vm.hostname = "base-vm"

#       config.vm.provider "vmware_fusion" do |v|
#         v.vmx["memsize"] = opts[:mem]
#         v.vmx["numvcpus"] = opts[:cpu]
#       end
      config.vm.provider "virtualbox" do |v|
        v.name = opts[:name]
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
    end
  end

  # Generic initialization
  config.vm.provision "shell", path: "src/scripts/init/start.sh"

  # copy required tar for installation
  config.vm.provision "file", source: "src/tar/basic", destination: "/tmp/"

  # copy xsync
  config.vm.provision "file", source: "src/scripts/init/xsync", destination: "/tmp/"

  # java development kit 8 installation
  config.vm.provision "shell", path: "src/scripts/init/jdk8_install.sh"

  # Scala 2.12.13 installation
  config.vm.provision "shell", path: "src/scripts/init/scala_install.sh"

  # xsync installation
  config.vm.provision "shell", path: "src/scripts/init/xsync_install.sh"

  # Closing provisioning
  config.vm.provision "shell", path: "src/scripts/init/closure.sh"
end