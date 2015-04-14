include_attribute 'mariadb::default'

default['mariadb']['use_default_repository'] = true

default['mariadb_chef']['database_data_bag_name'] = 'databases'
default['mariadb_chef']['user_data_bag_name']     = 'users'
