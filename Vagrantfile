
Vagrant.configure("2") do |config|
	etcHosts = ""
	ingressNginx = ""
	wordpress = ""
	wordpressUrl = ""

	case ARGV[0]
	when "provision", "up"

	print "Do you want nginx as ingress controller (y/n) ?\n"
	ingressNginx = STDIN.get.chomp
	print "\n"
  
	if ingressNginx == "y"
		print "Do you want a wordpress in your kubernetes cluster (y/n) ?\n"
		wordpress = STDIN.gets.chomp
		print "\n"

		if wordpress == "y"
			print "Wich url for your wordpress ?\n"
			wordpressUrl = STDIN.gets.chomp
			unless wordpressUrl.empty? then wordpressUrl else 'wordpress.kub' end
      	end
	end
	else
	# do nothing
	end


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
	if node[:type] != "haproxy"
		etcHosts += "echo '" + node[:ip] + "   " + node[:hostname] + "' >> /etc/hosts" + "\n"
	else
		etcHosts += "echo '" + node[:ip] + "   " + node[:hostname] + "'  autoelb.kub ' >> /etc/hosts" + "\n"
	end
	end


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
			end #end provider
			#for all
			cfg.vm.provision :shell, inline=> etcHosts
			if node[:type] == "haproxy"             aaa         
				cfg.vm.provision :shell, path=> "install_haproxy.sh"
			end
			if node[:type] == "kub"
				cfg.vm.provision :shell, path=> "common.sh"
			end
			if node[:type] == "deploy"
				cfg.vm.provision :shell, path=> "common.sh"
				cfg.vm.provision :shell, path=> "install_kubspray.sh", :args => ingressNginx
				if wordpress == "y"
					cfg.vm.provision :shell, path=> "install_nfs.sh"
					cfg.vm.provision :shell, path=> "install_wordpress.sh", args => wordpressUrl
				end
			end
		end # end config
	end #end node
end
								