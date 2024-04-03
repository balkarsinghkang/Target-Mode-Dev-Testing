require 'cisco_node_utils'
require_relative '../libraries/TargetModeHelpers' unless defined?(TargetModeHelpers::TargetModeHelper)
require 'pry'

resource_name :cisco_motd
provides :cisco_motd, target_mode: true
unified_mode true
default_action :set

# property :directory, String
property :target, String, name_property: true
# property :username, String, required: true
# property :password, String, required: true
# property :enable_password, String, required: true
property :motd, String
#, required: true

load_current_value do |current_value|
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    src = backend.run_command('show running-config | include motd').scan(/banner motd \^C (.*) /).flatten.first

  
    # if cfg.interfaces.has_key?(new_resource.name)
    #   iface = cfg.interfaces[new_resource.name]
  
    #   name        iface.option['name']        if iface.option.has_key?('name')
    #   type        iface.option['type']        if iface.option.has_key?('type')
    #   ifname      iface.option['ifname']      if iface.option.has_key?('ifname')
    #   proto       iface.option['proto']       if iface.option.has_key?('proto')
    #   ipaddress   iface.option['ipaddr']      if iface.option.has_key?('ipaddr')
    #   netmask     iface.option['netmask']     if iface.option.has_key?('netmask')
    #   gateway     iface.option['gateway']     if iface.option.has_key?('gateway')
  
    # end
  end


action :set do
  converge_if_changed do
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    binding.pry
    # src = backend.run_command('sh run')
    backend.run_command('show running-config | include motd')

    # cfg = OpenWRT::Config::Network.new(content: src)
    # ruby_block 'always_updated' do
    #  block do
    # cisco = Cisco::Base.new(host: new_resource.target, user: new_resource.username, password: new_resource.password, transport: :ssh)
    # cisco.enable(new_resource.enable_password)
    # cisco.cmd('config t')
    # cisco.cmd("banner motd # #{new_resource.motd} #")
    # cisco.cmd('exit')
    # output = cisco.run
    backend.run_command('config t')
    backend.run_command("banner motd # #{new_resource.motd} #")
    backend.run_command('exit')
    backend.run_command('wr mem')
    # end

    # Chef::Log.info('This resource is always updated')
  end
  updated_by_last_action true
  # end
end
