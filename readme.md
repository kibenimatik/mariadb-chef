# MariaDB-chef

This cookbook contains all required stuffs to run mariadb-server and some stuff to manage database and users. It is assumed that will be used as part of another cookbook.


## DEPENDENCIES

* [mariadb](https://supermarket.chef.io/cookbooks/mariadb) - installs mariadb-server package, [source](https://github.com/sinfomicien/mariadb)
* [database](https://supermarket.chef.io/cookbooks/database) - provides LWRPs to manage databases and users, [source](https://github.com/opscode-cookbooks/database)
* [mysql2_chef_gem](https://supermarket.chef.io/cookbooks/mysql2_chef_gem) - installs Ruby `mysql2` gem, required by `database` cookbook, [source](https://github.com/sinfomicien/mysql2_chef_gem)


## COOKBOOK ATTRIBUTES

See `mariadb` cookbooks attributes. Also

`['mariadb_chef']['database_data_bag_name']` - name of data_bag folder where database items are stored, default is "databases"
`default['mariadb_chef']['user_data_bag_name']` - name of data_bag folder where user items are stored, default is "users"




## GETTING STARTED

### bundle and update cookbooks

* `$ bundle install`
* `$ berks install`

## USAGE

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
