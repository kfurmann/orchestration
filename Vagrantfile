# run `vagrant plugin install vagrant-cachier` before `vagrant up`
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64" #"ubuntu/ubuntu-core-devel-amd64" 
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = false
    config.cache.enable :apt
    config.cache.enable :composer
  end
  config.vm.provision :shell, :path => "bootstrap.sh", :args => ENV["GITHUB_OAUTH_TOKEN"]
  config.vm.network :forwarded_port, host: 8000, guest: 80
  config.vm.network :forwarded_port, host: 8080, guest: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.synced_folder "repo", "/home/vagrant/repo"
end
