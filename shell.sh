#!/usr/bin/bash

args=$1

if [ ! -z ${args} ]; then
	bash scripts/argsAuth.sh $@
else
	echo "Usage: $0 <start|stop>"
	exit 1
fi


if [ $? -eq 0 ]; then
	if [ ${args} = "start" -o ${args} = "stop" ]; then
		expect -f scripts/hadoopManage.exp ${args}
	elif [ ${args} = "install" ]; then
		expect -f scripts/install.exp $2
	fi
fi

