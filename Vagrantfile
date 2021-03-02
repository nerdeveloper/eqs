Vagrant.configure("2") do |config|


  config.vm.define "kubernetes-master" do  |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "kubernetes-master"
    master.vm.network "public_network", ip: "192.168.0.17"
  end

  config.vm.define "ubuntu" do  |ubuntu|
      ubuntu.vm.box = "ubuntu/bionic64"
      ubuntu.vm.hostname = "ubuntu"
      ubuntu.vm.network "public_network", ip: "192.168.0.18"
  end
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

   # Provision Settings
   config.vm.provision "shell", path: "scripts/helm.sh"

  #
  # Run Ansible from the Vagrant Host
  #


  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.galaxy_roles_path = "./roles"
    ansible.verbose = true
    ansible.groups = {
         "master" =>  ["kubernetes-master"],
         "ubuntu"  => ["ubuntu"],
         "all:children" => ["master", "ubuntu"]


   }


  end

end
