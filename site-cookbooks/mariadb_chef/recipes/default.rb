include_recipe "mariadb::server"

mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mariadb
  action :install
end

include_recipe "#{cookbook_name}::databases"
include_recipe "#{cookbook_name}::users"
