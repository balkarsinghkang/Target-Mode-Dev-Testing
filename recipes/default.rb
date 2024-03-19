#
# Cookbook:: tmt
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

cisco_motd '192.168.240.5' do
  username 'admin'
  password 'Training'
  enable_password 'Training'
  motd 'Configured via Chef recipe Balkar and Anil'
end
