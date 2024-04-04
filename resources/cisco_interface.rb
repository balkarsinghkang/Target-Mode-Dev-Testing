require_relative '../libraries/TargetModeHelpers' unless defined?(TargetModeHelpers::TargetModeHelper)
require 'pry'
# require 'json'
resource_name :cisco_interfdace
provides :cisco_interface, target_mode: true
unified_mode true
default_action :update

property :interface, String, name_property: true
property :target, String, required: true
property :description, String
property :shutdown, [true, false], required: true

def string_not_nil?(str)
    return str != nil
  end

load_current_value do |new_resource|
    backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
    int_cfg = backend.run_command("show running-config interface #{new_resource.interface}")
    description int_cfg.split("\r\n").find { |item| item.lstrip.start_with?("description")}.lstrip.match(/description "(.*?)"/)[1]
    shutdown string_not_nil?(int_cfg.split("\r\n").find { | str | str.match(/\s*shutdown/)})
  end

action :update do
  backend = TargetModeHelpers::TargetModeHelper.new(__transport_connection)
  backend.run_command('config t')
  backend.run_command("interface #{new_resource.interface}")
  
  converge_if_changed :description do
    backend.run_command("description #{new_resource.description}")
  end

  converge_if_changed :shutdown do
    backend.run_command("shutdown") if new_resource.shutdown == true
  end
  backend.run_command('exit')
  backend.run_command('exit')
  backend.run_command('wr mem')
end
