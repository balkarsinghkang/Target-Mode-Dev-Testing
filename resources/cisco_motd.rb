# require 'cisco_node_utils'
require_relative '../libraries/TargetModeHelpers' unless defined?(TargetModeHelpers::TargetModeHelper)
require 'pry'

resource_name :cisco_motd
provides :cisco_motd, target_mode: true
unified_mode true
default_action :set

property :target, String, name_property: true
property :motd, String
#, required: true

load_current_value do |new_resource|
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    motd = backend.run_command('show running-config | include motd').scan(/banner motd \^C (.*) /).flatten.first
  end

action :set do
 #   binding.pry
  converge_if_changed :motd do
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    src = backend.run_command('show running-config | include motd').scan(/banner motd \^C (.*) /).flatten.first
    backend.run_command('config t')
    backend.run_command("banner motd # #{new_resource.motd} #")
    backend.run_command('exit')
    backend.run_command('wr mem')
  end 
end
