Vagrant.configure("2") do |config|
config.vm.box = #"ubuntu/ubuntu-core-devel-amd64" 
"ubuntu/trusty64"
#config.vm.box_url = "https://vagrantcloud.com/hashicorp/boxes/precise32/versions/1.0.0/providers/virtualbox.box"
#config.vm.box_url = "https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.04/ubuntu-14.04-amd64.box"
config.vm.provision :shell, path: "bootstrap.sh"
config.vm.network :forwarded_port, host: 8000, guest: 80
config.vm.network :forwarded_port, host: 8080, guest: 8080
#config.vm.network :forwarded_port, host: 4848, guest: 4848
#config.vm.network :forwarded_port, host: 8005, guest: 8005
config.vm.network :forwarded_port, host: 3306, guest: 3306
config.vm.provider "virtualbox" do |v|
	v.memory = 2048
  	v.cpus = 2
end
end
