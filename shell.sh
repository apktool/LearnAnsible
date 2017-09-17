#!/usr/bin/expect

spawn ansible-playbook -i hosts site.yml --ask-pass
expect "password:"
send "root\r"
interact
