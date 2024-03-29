require 'base64' unless defined?(Base64)

class TargetModeHelper
  def empty(x)
    (!x.nil? and x.strip.empty?)
  end

  def initialize(backend)
    @backend = backend
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
Chef::DSL::Recipe.send(:include, TargetModeHelper)