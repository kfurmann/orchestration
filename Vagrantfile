# run `vagrant plugin install vagrant-cachier` before `vagrant up`
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64" #"ubuntu/ubuntu-core-devel-amd64" 
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = false
#    config.cache.enable :generic, {
#      "wget" => { cache_dir: "~/.vagrant.d/cache/wget" },
#    }
#    config.cache.enable_nfs  = true
    config.cache.enable :apt
    config.cache.enable :composer
  end
  config.vm.define "php", primary: true do |php|
    php.vm.network "private_network", ip: "192.168.50.4"
    php.vm.provision :shell, :path => "bootstrap_php.sh", :args => ENV["GITHUB_OAUTH_TOKEN"], privileged: false
    php.vm.network :forwarded_port, host: 8000, guest: 80
    php.vm.network :forwarded_port, host: 3306, guest: 3306
  end
  config.vm.define "java", autostart: false do |java|
    java.vm.network "private_network", ip: "192.168.50.3"
    java.vm.provision :shell, :path => "bootstrap_java.sh", :args => ENV["GITHUB_OAUTH_TOKEN"], privileged: false
    java.vm.network :forwarded_port, host: 8080, guest: 8080
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.synced_folder "repo", "/home/vagrant/repo"
end
