#!/usr/bin/expect

spawn ansible-playbook -i hosts startHadoop.yml --ask-pass
expect "password:"
send "root\r"
interact
