#!/usr/bin/expect -f

set ipadr [lindex $argv 0]
set cmd [lindex $argv 1]
set fich [lindex $argv 2]

spawn ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 admin@${ipadr}
expect {
"Password:"  { send "Training\r" }
# "(yes/no)?"  { send "yes\r"; expect { "password:" { send "YOURPASSWORDHERE\r"; }}}
#"Name:"      { send "YOURUSERNAMEHERE\r"; sleep 3 ; send "YOURPASSWORDHERE\r"; }
#"Connection refused" { exit }
}

expect {
">" { send "en\r" ; sleep 3; send "Training\r";}
"#" { send "\r" }
}

expect {
"#" { send "terminal length 0" ; sleep 1; send "\r" }
}

expect {
"#" { send "${cmd}" ; sleep 5; send "\r" ;send "\r" }
}

expect {
"#" { send "exit\r"; send "quit\r" }
}