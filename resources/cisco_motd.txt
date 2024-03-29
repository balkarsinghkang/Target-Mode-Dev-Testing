# require 'TargetModeHelper'
# unless defined?(TargetModeHelper)
# require 'Tmt::CiscoHelpers'
# Chef::Recipe.send(:include, Tmt::CiscoHelpers)
# require 'net/ssh'

resource_name :cisco_motd
provides :cisco_motd # , target_mode: true
unified_mode true
default_action :set

# property :directory, String
property :target, String, name_property: true
property :username, String, required: true
property :password, String, required: true
property :enable_password, String, required: true
property :motd, String, required: true

# load_current_value do |new_resource|
#   backend = TargetModeHelper.new(__transport_connection)

#   dir = new_resource.directory
#   parsed = dir.match(%r{([^/]+$)})
#   path = ''
#   if parsed
#     path = dir[0..(dir.length - parsed[1].length - 1)]
#     dir = parsed[1]
#   end

#   tmp = backend.run_command('ls -l %s | grep %s || echo -n', path, dir)
#   if tmp.match(Regexp.new(dir))
#     directory new_resource.directory
#   end
# end
action :set do
  #   backend = TargetModeHelper.new(__transport_connection)
  #   converge_if_changed do
  #     backend.run_command('mkdir %s', new_resource.directory)
  #   end
  # ruby_block 'always_updated' do
  #  block do
  cisco = Cisco::Base.new(host: new_resource.target, user: new_resource.username, password: new_resource.password, transport: :ssh)
  cisco.enable(new_resource.enable_password)
  cisco.cmd('config t')
  cisco.cmd("banner motd # #{new_resource.motd} #")
  cisco.cmd('exit')
  output = cisco.run

  enable
  conf t
int 1
ip addree 
  # Chef::Log.info('This resource is always updated')
  # end
  # updated_by_last_action true
  # end
end
