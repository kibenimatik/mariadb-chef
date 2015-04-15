connection_info = {
  :host     => node['mariadb']['mysqld']['bind_address'],
  :username => 'root',
  :password => node['mariadb']['server_root_password']
}

# Name of data_bag folder where information about databases is stored
database_data_bag = node['mariadb_chef']['database_data_bag_name']

# Iterate through each database item
data_bag(database_data_bag).each do |key|
  # retrieve information about database to create
  data = data_bag_item(database_data_bag, key)

  # create database
  mysql_database data['name'] do
    connection  connection_info
    encoding    data['encoding']
    collation   data['collation']
    action      :create
  end
end
