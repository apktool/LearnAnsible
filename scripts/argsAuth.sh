#!/usr/bin/bash

args=$1
grepresult=`grep "motivation" group_vars/all | awk '{print $2}'`

if [ ${args} != "start" -a ${args} != "stop" ]; then
	echo "Parameter Error: start|stop"
	exit 1
fi

if [ ${args} = "start" ]; then
	sed -i "s/${grepresult}/start/g" group_vars/all
fi

if [ ${args} = "stop" ]; then
	sed -i "s/${grepresult}/stop/g" group_vars/all
fi
