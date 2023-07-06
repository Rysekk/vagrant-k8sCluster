
Vagrant.configure("2") do |config|
    
  config.vm.box="ubuntu/bionic64"
  config.vm.box_url="ubuntu/bionic64"

    #set server name and their parameters
  NODES = [
    {:hostname => "autohaprox", :ip => "192.168.12.10", :cpus => 1, :mem => 512, :type => "haproxy" },
    {:hostname => "autokmaster", :ip => "192.168.12.11", :cpus => 4, :mem => 4096, :type => "kub" },
    {:hostname => "autonode1", :ip => "192.168.12.12", :cpus => 2, :mem => 2048, :type => "kub" },
    {:hostname => "autonode2", :ip => "192.168.12.13", :cpus => 2, :mem => 2048, :type => "kub" },
    {:hostname => "autodep", :ip => "192.168.12.20", :cpus => 1, :mem => 512, :type => "deploy" }
  ]

  NODES.each do |node|
    config.vm.define node[:hostname] do |cfg|
      cfg.vm.hostname = node[:hostname]
      cfg.vm.network "private_network", ip: node[:ip]
      cfg.vm.provider "virtualbox" do |v|
        v.customize["modifyvm", :id, "--cpus", node[:cpus]]
        v.customize["modifyvm", :id, "--memory", node[:mem]]
        v.customize["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize["modifyvm", :id, "--name", node[:hostname]]
      end
      cfg.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision.yml"
      end
    end
end
