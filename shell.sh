#!/usr/bin/bash

args=$1

if [ ! -z ${args} ]; then
	bash scripts/argsAuth.sh ${args}
else
	echo "Usage: $0 <start|stop>"
	exit 1
fi

if [ $? -eq 0 ]; then
	expect -f scripts/hadoopManage.sh
fi

