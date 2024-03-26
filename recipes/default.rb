#
# Cookbook:: tmt
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

gem_package 'cisco_node_utils' 
# do
#   source '/Users/balkarsinghkang/Downloads/cisco_node_utils-2.1.0.gem'
# end


cisco_motd '192.168.240.5' do
  username 'admin'
  password 'Training'
  enable_password 'Training'
  motd 'Configured via Chef recipe Balkar'
end
