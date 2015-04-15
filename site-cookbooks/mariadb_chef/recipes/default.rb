# Install MariaDB server
include_recipe "mariadb::server"

# Install 'mysql2' gem
mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mariadb
  action :install
end

# Create databases and users
include_recipe "#{cookbook_name}::databases"
include_recipe "#{cookbook_name}::users"
