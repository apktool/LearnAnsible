#!/usr/bin/bash

args=$1
grepresult=`grep "motivation" group_vars/all | awk '{print $2}'`

if [ -z ${args} ]; then
	echo "Usage: $0 <start|stop>"
	exit 2
elif [ ${args} != "start" -a ${args} != "stop" ]; then
	echo "Parameter Error: start|stop"
	exit 2
fi

if [ ${args} = "start" ]; then
	sed -i "s/${grepresult}/start/g" group_vars/all
fi

if [ ${args} = "stop" ]; then
	sed -i "s/${grepresult}/stop/g" group_vars/all
fi

expect -f scripts/startAnsible.sh

: <<'END'
spawn ansible-playbook -i hosts site.yml --ask-pass
expect "password:"
send "root\r"
interact
END
