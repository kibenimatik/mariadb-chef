MariaDB-chef
======

This cookbook contains all required stuffs to run mariadb-server and some stuff to manage database and users. It is assumed that will be used as part of another cookbook.


DEPENDENCIES
-------

* [mariadb](https://supermarket.chef.io/cookbooks/mariadb) - installs mariadb-server package ([source](https://github.com/sinfomicien/mariadb))
* [database](https://supermarket.chef.io/cookbooks/database) - provides LWRPs to manage databases and users ([source](https://github.com/opscode-cookbooks/database))
* [mysql2_chef_gem](https://supermarket.chef.io/cookbooks/mysql2_chef_gem) - installs Ruby `mysql2` gem, required by `database` cookbook ([source](https://github.com/sinfomicien/mysql2_chef_gem))


COOKBOOK CUSTOMIZATION
-----------

See `mariadb` cookbooks attributes for configuring MariaDB server.

`['mariadb_chef']['database_data_bag_name']` - name of data_bag folder where database items are stored, default is "databases"
`default['mariadb_chef']['user_data_bag_name']` - name of data_bag folder where user items are stored, default is "users"

### Sample database item
`/data_bags/databases/db1.json`
```json
{
  "id": "db1", // required
  "name": "another_database", //database name, required
  "encoding": "utf8", // optional
  "collation": "utf8_general_ci" //optional
}

```

### Sample user item
`/data_bags/databases/user1.json`
```json
{
  "id": "user1", // required
  "username": "alex", // required
  "password": "123456", // required
  "host": "%", // optional, default is 'localhost'
  "database_name": "test_database", // optional, default is 'all'
  "privileges": ["select","update","insert"] // optional, array, default is ['all']
}
```

Encryption
----------

Here is suggested setup to encrypt data_bags.

1) Generate secret key
`openssl rand -base64 512 > ~/encrypted_data_bag_secret`

2) Edit `.chef/knife.rb`, set full path to generated secret file
`encrypted_data_bag_secret "/Users/timur/encrypted_data_bag_secret"`

That is all, now chef-solo can work both with encrypted and unencrypted data bag items.

#### How to create encrypted data bag item

1) Set environment variable `EDITOR` to some console editor like vim
`export EDITOR=$(which vim)`
2) Create user data bag item "dylan" (/data_bags/users/dylan.json)
`knife solo data bag create users dylan`
3) Data bag will be created and encrypted after exiting from editor


#### How to edit encrypted data bag item
1) Set environment variable `EDITOR`

2) Edit data bag item "alex" (/data_bags/users/alex.json)
`knife solo data bag edit users dylan`
3) Save file

For more information about using encrypted data bags see https://github.com/thbishop/knife-solo_data_bag


NOTE: For demonstration purpose Knife is already configured to work with commmited `encrypted_data_bag_secret` file


## GETTING STARTED

### bundle and update cookbooks

* `$ bundle install`
* `$ berks install`

### prepare server
* Edit `roles/database.json` or create another role
* Copy `nodes/127.0.0.1.json` to `nodes/server.com.json` and edit it if needed
* Ensure that you have root access or sudo rights to your server, also you may copy your public ssh key to avoid password prompt
* Run `knife solo prepare root@yourserver.com`

### Cook recipe

* `$ knife solo cook root@yourserver.com`

## TEST WITH VAGRANT

* Download and install Vagrant - http://www.vagrantup.com/downloads.html
* Download and install VirtualBox - https://www.virtualbox.org/wiki/Downloads
* `$ vagrant up`
* `$ knife solo prepare vagrant@127.0.0.1 --ssh-port 2222 --identity-file ~/.vagrant.d/insecure_private_key`
* `$ knife solo cook vagrant@127.0.0.1 --ssh-port 2222 --identity-file ~/.vagrant.d/insecure_private_key`
* `$ vagrant halt`

Correct path to identity file might be picked from `vagrant ssh-config` output
