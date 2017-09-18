#!/usr/bin/expect

set args [lindex $argv 0];

if {[ regexp -nocase "$args" "start" ]} {
	set playbook "startHadoop"
} else {
	set playbook "stopHadoop"
}

spawn ansible-playbook -i hosts ${playbook}.yml --ask-pass
expect "password:"
send "root\r"
interact
