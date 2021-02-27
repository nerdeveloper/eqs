Vagrant.configure("2") do |config|


  config.vm.define "kubernetes-master" do  |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "kubernetes-master"
    master.vm.network "public_network", ip: "192.168.0.17",  bridge: [
    "en0: Wi-Fi (Wireless)",
    "bridge0"
    ]
  end

  config.vm.define "kubernetes-worker" do  |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.vm.hostname = "kubernetes-worker"
      worker.vm.network "public_network", ip: "192.168.0.18",  bridge: [
          "en0: Wi-Fi (Wireless)",
          "bridge0"
          ]
  end
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end
  #
  # Run Ansible from the Vagrant Host
  #


  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.galaxy_roles_path = "./roles"
    ansible.verbose = true
    ansible.groups = {
         "master" =>  ["kubernetes-master"],
         "worker"  => ["kubernetes-worker"]
   }


  end

end
