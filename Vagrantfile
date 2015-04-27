Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64" #"ubuntu/ubuntu-core-devel-amd64" 
  config.vm.provision :shell, :path => "bootstrap.sh", :args => ENV["GITHUB_OAUTH_TOKEN"]
  config.vm.network :forwarded_port, host: 8000, guest: 80
  config.vm.network :forwarded_port, host: 8080, guest: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.synced_folder "www", "/var/www"
end
