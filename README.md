Documents:

Target Mode Link: https://chefio.atlassian.net/wiki/spaces/~5ec4d1fdde8fe30c44a98c26/pages/2864381992/Target+Mode

https://www.rubydoc.info/gems/cisco_node_utils/2.1.0
https://github.com/cisco/cisco-network-chef-cookbook
https://supermarket.chef.io/cookbooks/cisco-cookbook

Pre-requisites:
Configure cisco account must be configured with enable access. The following command used to setup admin account.

login with admin
enable
conf t
username admin2 privilege 15 secret Training
aaa new-model
!
!
aaa authentication login default local
aaa authorization exec default local
line vty 0 4
 privilege level 15
 transport input ssh
line vty 5 15
 privilege level 15
 transport input ssh
exit
exit
wr mem
exit

login with the following to get into enable mode
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 admin2@192.168.240.5

Here are a few examples of how to use the custom resources for Cisco commands

cisco = Cisco::Base.new(:host => "10.0.0.1", :user => "admin", :password => "accesspass", :transport => :ssh)

cisco.cmd("sh ver")

cisco.enable("enablepass")

cisco.cmd("sh run")

output = cisco.run

This will return an array of results, one string for the output of each command. The
following block style usage returns the same results, though some may prefer it:

output = cisco.run do |x|

	x.cmd("sh ver")

	x.enable("enablepass")

	x.cmd("sh run")

end



You can also pass an array of direct arguments that are used to instantiate the transport object. 
This is useful, if for instance, you want to use public key authentication with SSH:

cisco = Cisco::Base.new(:directargs => ["10.0.0.1", "admin", :auth_methods => ["publickey"]])


Known Errors
#1
Error
FATAL: ArgumentError: Cannot find a platform for node[ciscoswitch]
FATAL: ArgumentError: Cannot find a version for node[ciscoswitch]
Fix
vi /opt/chef-workstation/embedded/lib/ruby/gems/3.0.0/gems/chef-17.6.18/lib/chef/platform/provider_mapping.rb
 39         platform = 'ios'
 40         #raise ArgumentError, "Cannot find a platform for #{node}" unless platform

 49         version = '10.1'
 50         #raise ArgumentError, "Cannot find a version for #{node}" unless version