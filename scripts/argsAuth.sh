#!/usr/bin/bash

args=$1
grepresult=`grep "motivation" group_vars/all | awk '{print $2}'`

if [ ${args} != "start" -a ${args} != "stop" -a ${args} != "install" ]; then
	echo "Parameter Error: start|stop|install"
	exit 1
fi

if [ ${args} = "start" ]; then
	sed -i "s/${grepresult}/start/g" group_vars/all
fi

if [ ${args} = "stop" ]; then
	sed -i "s/${grepresult}/stop/g" group_vars/all
fi

if [ ${args} = "install" ]; then
	if [ -z $2 ]; then
		echo "Lack of Parameter: centos|hadoop"
		exit 1
	elif [ $2 != "centos" -a $2 != "hadoop" ]; then
		echo "Parameter Error after install: centos|hadoop"
		exit 1
	else
		sed -i "s/${grepresult}/install/g" group_vars/all
	fi
fi
