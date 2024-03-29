require 'cisco_node_utils'

resource_name :cisco_interface
provides :cisco_interface # , target_mode: true
unified_mode true
default_action :set

# property :directory, String
property :target, String, name_property: true
property :username, String, required: true
property :password, String, required: true
property :enable_password, String, required: true
property :interface, String, required: true
property :sub_interface, String
property :description, String, required: true
property :state, String, required: true
property :ipaddress, String, required: true

action :set do
  client1 = Cisco::Client.create()
  env = { host: new_resource.target, port: nil, username: new_resource.username, password: new_resource.password, cookie: nil }

