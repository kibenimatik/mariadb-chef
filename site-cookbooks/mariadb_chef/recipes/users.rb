connection_info = {
  :host     => node['mariadb']['mysqld']['bind_address'],
  :username => 'root',
  :password => node['mariadb']['server_root_password']
}

user_data_bag = node['mariadb_chef']['user_data_bag_name']

data_bag(user_data_bag).each do |key|
  data = data_bag_item(user_data_bag, key)

  # create user, privileges are not granted
  mysql_database_user data['username'] do
    connection  connection_info
    password    data['password']
    host        data['host']

    action      :create
  end

  # grant privileges to the user
  mysql_database_user data['username'] do
    connection  connection_info
    password    data['password']
    host        data['host']

    database_name data['database_name']
    privileges    data['privileges']

    action :grant
  end
end
