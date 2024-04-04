require_relative '../libraries/TargetModeHelpers' unless defined?(TargetModeHelpers::TargetModeHelper)
require 'pry'
# require 'json'
resource_name :cisco_interfdace
provides :cisco_interface, target_mode: true
unified_mode true
default_action :set

property :interface, String, name_property: true
property :target, String, required: true
property :description, String
property :shutdown, String, required: true


load_current_value do |new_resource|
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    int_cfg = backend.run_command("show running-config interface #{new_resource.interface}")
    description int_cfg.split("\r\n").find { |item| item.lstrip.start_with?("description")}.lstrip.match(/description "(.*?)"/)[1]
    shutdown string_not_nil?(int_cfg.split("\r\n").find { | str | str.match(/\s*shutdown/)})
    binding.pry
  end

action :update do

#   converge_if_changed :description do
#     backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
#     backend.run_command('config t')
#     backend.run_command("banner motd # #{new_resource.motd} #")
#     backend.run_command('exit')
#     backend.run_command('wr mem')
#   end 
end
