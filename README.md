
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