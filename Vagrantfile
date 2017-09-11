Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  ##
  # Networking Setup
  ##
  #config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  ##
  # Application Setup
  ##
  config.vm.synced_folder "application", "/opt/app/"

  ##
  # Provisioning Logic
  ##
  config.vm.synced_folder "salt/base", "/srv/salt/formulas/base"
  config.vm.synced_folder "salt/pillar", "/srv/salt/pillar/base/"

  #TODO: Investigate tornado python lib issue for salt dependency
  config.vm.provision "shell", path: "scripts/salt_dependencies.sh"

  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.install_type = "git"
    salt.install_args = "v2016.11.7"
    salt.bootstrap_options = "-P -c /tmp"

    salt.minion_config = "salt/minion"
    salt.colorize = true
    salt.verbose = true
    salt.log_level = "debug"
    salt.run_highstate = true
  end
end