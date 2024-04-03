#
# Cookbook:: tmt
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

# chef_gem 'cisco_node_utils' do
#   source '/root/cisco_node_utils-2.1.1.gem'
# end

cisco_motd '192.168.240.5' do
  motd 'Configured via Chef recipe Balkar3'
end

cisco_interface 'Gi1/0/10' do
  target '192.168.240.5'
  interface 'Gi1/0/10'
  description "Configured with recipe"
  enabled true # enabled true mean no shutdown; enabled false mean shutdown
end
