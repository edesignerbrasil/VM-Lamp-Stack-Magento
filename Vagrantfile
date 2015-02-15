# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "hashicorp/precise32"  

  config.vm.define :vmhf do |vmHF_config|
    vmhf_config.vm.network :private_network, :ip => "192.168.33.10"    
    # Share an additional folder to the guest VM. The first argument is the path on the host to the actual folder.
    # The second argument is the path on the guest to mount the folder.
    vmhf_config.vm.synced_folder "/home/charleseduardo/VM-Vagrants/VM-Lamp-Stack-Magento/magento", "/var/www/"

    vmhf.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
      puppet.manifest_file = "lamp.pp"
     
    end
  end
end


