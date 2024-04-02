control '************ 1-check_HTTPS_firewall ************' do
  impact 1.0
  title 'check_firewall'
  describe file('/etc/config/firewall'), :sensitive do
    its('content') { should match /option name 'Allow-HTTPS'/ }
    its('content') { should match /option dest_port '443'/ }
    its('content') { should match /option proto 'TLS'/ }
  end
end

control '************ 2-check_for_file_and_port ************' do
  impact 0.6
  title 'check_firewall'
  describe file('/root/ip_details/ip.txt') do
      it { should exist }
  end
  describe port(80) do
    it { should_not be_listening }
end
end

control '************ 3-check_FTP_firewall ************' do
  impact 0.8
  title 'check_firewall'
  describe file('/etc/config/firewall'), :sensitive do
    its('content') { should match /option name 'Block-FTP'/ }
    its('content') { should match /option dest_port '21'/ }
  end
end

