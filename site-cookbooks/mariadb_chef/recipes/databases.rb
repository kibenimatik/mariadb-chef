connection_info = {
  :host     => node['mariadb']['mysqld']['bind_address'],
  :username => 'root',
  :password => node['mariadb']['server_root_password']
}

database_data_bag = node['mariadb_chef']['database_data_bag_name']

data_bag(database_data_bag).each do |key|
  data = data_bag_item(database_data_bag, key)

  mysql_database data['name'] do
    connection  connection_info
    encoding    data['encoding']
    collation   data['collation']
    action      :create
  end
end
