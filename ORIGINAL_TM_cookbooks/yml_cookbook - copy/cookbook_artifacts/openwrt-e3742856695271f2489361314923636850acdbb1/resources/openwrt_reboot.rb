require 'TargetModeHelper' unless defined?(TargetModeHelper)

resource_name :openwrt_reboot
provides :openwrt_reboot, target_mode: true
unified_mode true # , platform: "linux"

property :delay, Integer
default_action :nothing

action :create do
  # this is an empty resource action
end

action :reboot do
  converge_if_changed do
    backend = TargetModeHelper.new(__transport_connection)
    backend.run_command(format('reboot -d %s & echo -n', new_resource.delay))
  end
end

# notifies :restart, 'service[chef-elasticsearch]', :delayed
