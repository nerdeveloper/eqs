# EQS Interview Test
This is an Ansible script that spins up single node Cluster, Install Helm and Vault.

## Installation
- [Vagrant](https://www.vagrantup.com/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Development

### Provisioning
- Git clone the repo and Enter the directory
```shell
git clone https://github.com/nerdeveloper/eqs
cd eqs
```
- Open the `VagrantFile` file and update your public and private IP address 
- Open the `group_vars/all.yaml` file and update `master_ip` and `private_ip`

- Run the command to bring up the services
```shell
vagrant up --provision
```

- Run this command to tear down the services
```shell
vagrant destroy -f 
```


## Production
### Provisioning
- Git clone the repo and Enter the directory
```shell
git clone https://github.com/nerdeveloper/eqs
cd eqs
```
- Open the `inventory.ini` file and update your public ip address to the VM, the user and update the path to you SSK key.
- Open the `group_vars/all.yaml` file and update `master_ip` and `private_ip`

- Run the command to bring up the services
```shell
vagrant up --provision
```

- Run this command to tear down the services
```shell
vagrant destroy -f 
```

