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
property :motd, String, required: true

action :set do
  converge_if_changed do
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    # binding.pry
    # src = backend.run_command('sh run')
    backend.run_command('sh run')

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
    backend.run_command("echo '#{new_resource.motd}' > /etc/motd")
    backend.run_command('exit')
    # end

    # Chef::Log.info('This resource is always updated')
  end
  # updated_by_last_action true
  # end
end
