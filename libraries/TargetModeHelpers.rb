#
# Chef Infra Documentation
# https://docs.chef.io/libraries/
#

#
# This module name was auto-generated from the cookbook name. This name is a
# single word that starts with a capital letter and then continues to use
# camel-casing throughout the remainder of the name.
#
require 'base64' unless defined?(Base64)

module TargetModeHelpers
  #
  # Define the methods that you would like to assist the work you do in recipes,
  # resources, or templates.
  #
  class TargetModeHelper
    def empty(x)
      (!x.nil? and x.strip.empty?)
    end

    def initialize(backend)
      @backend = backend
      # puts "__transport_connection: #{@backend.__transport_connection}"
    end

    def run_command(command, *args, debug: false)
      unix_cmd = format(command, *args)
      cmd = @backend.run_command(unix_cmd)

      if debug
        puts ''
        puts '**************************************************'
        puts 'TargetModeHelper.run_command'
        puts format('Command: %s', unix_cmd)
        puts format('stdout: %s', cmd.stdout)
        puts format('stderr: %s', cmd.stderr)
        puts '**************************************************'
      end

      cmd.stdout
    end

    def read_text_file(file)
      unix_cmd = format('cat %s || echo -n', file)
      @backend.run_command(unix_cmd).stdout
    end

    def write_text_file(file, contents)
      encoded = Base64.strict_encode64(contents)
      unix_cmd = format("echo '%<base64>s' | base64 --decode > %<file>s", base64: encoded, file: file)
      @backend.run_command(unix_cmd).stdout
    end
  end
  def string_not_nil?(str)
    return str != nil
  end
end

#
# The module you have defined may be extended within the recipe to grant the
# recipe the helper methods you define.
#
# Within your recipe you would write:
#
#     extend ::TargetmodehelpersHelpers
#
#     my_helper_method
#
# You may also add this to a single resource within a recipe:
#
#     template '/etc/app.conf' do
#       extend ::TargetmodehelpersHelpers
#       variables specific_key: my_helper_method
#     end
#
Chef::DSL::Recipe.send(:include, TargetModeHelpers)
