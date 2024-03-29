module Tmt
  module CiscoHelpers
    require 'net/ssh'
    require 'pry'
    # class CiscoHelpers
    def cisco_command_executor(ip_address, username, password, _command)
      begin
      # Connect to the Cisco device using SSH
      Net::SSH.start(ip_address, username, password: password) do |ssh|
        ssh.open_channel do |channel|
          channel.exec('sh env all') do |_ch, success|
            abort 'sh env all could not execute command' unless success
            channel.on_data do |_ch, data|
              # binding.pry
              puts data
              channel.exec('enable') do |ch, stream, data|
                if stream == :stderr
                  puts "ERROR: #{data}"
                else
                  puts data
                  channel.on_data do |_ch, data|
                    channel.send_data "Training\n" do |ch, stream, data|
                      if stream == :stderr
                        puts "ERROR: #{data}"
                      else
                        puts data
                        channel.on_data do |_ch, data|
                          channel.exec('config t')do |ch, stream, data|
                          if stream == :stderr
                            puts "ERROR: #{data}"
                          else
                            puts data
                            channel.on_data do |_ch, data |
                              channel.exec('banner motd # Banner from ruby tmt #') do |ch, stream, data|
                              if stream == :stderr
                                puts "ERROR: #{data}"
                              else
                                puts data
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              # channel.send_data "Training\n"
              # channel.exec('config t')
              # channel.exec('banner motd # Banner from ruby tmt #')

              channel.on_extended_data do |_ch, _type, data|
                puts "got stderr: #{data}"
              end
              # binding.pry
            end
            # binding.pry
          end
          # channel.exec('enable') do |_ch, success|
          #   abort 'show run could not execute command' unless success
          #   channel.on_data do |_ch, data|
          #     channel.send_data "Training\n"
          #     #channel.exec('sh run')
          #     #  binding.pry
          #     puts data
          #   end
          #   # binding.pry
          # end

          # channel.exec('sh run') do |_ch, success|
          #   abort 'show run could not execute command' unless success
          #   channel.on_data do |_ch, data|
          #     binding.pry
          #     puts data
          #   end
          #   # binding.pry
          # end
          # binding.pry
          # Execute the command
          # puts command
          # puts '=========='
          # # binding.pry
          # channel.exec 'enable'
          # channel.send_data('Training')
          # output = channel.exec('show run aaa')

          # # Output the result
          # puts 'Command Output:'
          # puts output
          # # binding.pry
        end
        ssh.loop
      rescue Net::SSH::AuthenticationFailed
        puts 'Authentication failed. Please check your credentials.'
      rescue Net::SSH::ConnectionTimeout
        puts 'Connection timed out. Please verify the device IP address.'
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
    end
  end
end
end
Chef::DSL::Recipe.send(:include, Tmt::CiscoHelpers)
