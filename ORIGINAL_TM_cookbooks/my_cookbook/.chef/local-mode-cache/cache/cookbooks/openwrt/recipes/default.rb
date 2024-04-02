#
# Cookbook:: openwrt
# Recipe:: default

openwrt_directory 'IP_Details' do
  directory '~/ip_details'
end

openwrt_download 'my ip' do
  source 'http://api.ipify.org'
  target '~/ip_details/ip.txt'
end

openwrt_package 'base64' do
  package 'coreutils-base64'
end

openwrt_system_config '/etc/config/system' do
  hostname 'OpenWrt'
  conloglevel '7'
  notifies :reboot, 'openwrt_reboot[reboot]', :delayed
end

openwrt_network_interface 'lan' do
  type 'bridge'
  ifname 'eth0'
  proto 'static'
  ipaddress '192.168.0.251'
  netmask '255.255.255.0'
  gateway '192.168.0.1'
  notifies :reboot, 'openwrt_reboot[reboot]', :delayed
end

openwrt_uci_firewall 'Block-FTP' do
  src 'wan'
  dest	'lan'
  dest_port	'21'
  target 'REJECT'
  notifies :commit, 'openwrt_uci_apply[commit]', :immediately
end

openwrt_uci_firewall 'Allow-HTTPS' do
  src 'wan'
  dest 'lan'
  dest_port '443'
  proto 'TLS'
  target 'ACCEPT'
  notifies :commit, 'openwrt_uci_apply[commit]', :immediately
end

openwrt_network_route 'VLAN-1' do
  interface 'lan'
  target '192.168.0.244'
  gateway '192.168.0.251'
  notifies :reboot, 'openwrt_reboot[reboot]', :delayed
end

openwrt_uci_apply 'commit' do
  notifies :reboot, 'openwrt_reboot[reboot]', :delayed
end

openwrt_reboot 'reboot' do
  delay 10
end
