#
# Cookbook:: tmt
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

# require 'pry'

# chef_gem 'cisco_node_utils' do
#   source '/root/cisco_node_utils-2.1.1.gem'
# end

# binding.pry

cisco_motd '192.168.240.5' do
  # username 'admin'
  # password 'Training'
  # enable_password 'Training'
  motd 'Configured via Chef recipe Balkar'
end
