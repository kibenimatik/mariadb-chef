# MariaDB-chef

Chef recipe(s) to bundle MariaDB as standalone or among with other services.

## GETTING STARTED

### bundle and update cookbooks

* `$ bundle install`
* `$ berks install`

### Prepare destination server

### Cook

* `$ knife solo cook root@yourserver.com`

## TEST WITH VAGRANT

* Download and install Vagrant - http://www.vagrantup.com/downloads.html
* Download and install VirtualBox - https://www.virtualbox.org/wiki/Downloads
* `$ vagrant up`
* `$ knife solo prepare vagrant@127.0.0.1 --ssh-port 2222 --identity-file ~/.vagrant.d/insecure_private_key`
* `$ knife solo cook vagrant@127.0.0.1 --ssh-port 2222 --identity-file ~/.vagrant.d/insecure_private_key`
* `$ vagrant halt`

Correct path to identity file might be picked from `vagrant ssh-config` output
