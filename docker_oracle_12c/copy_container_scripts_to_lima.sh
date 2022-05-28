#!/bin/bash

if [[ $# -ne 3 ]];then
	echo "Usages: $0 <Container_id> <container_path> <lima_directory>"
	echo "		e.g., docker cp 61044efa80e6:/u01/scripts/ ."
	echo "		$0 61044efa80e6 /u01/scripts/ ."
	exit 1

fi

docker cp $1:$2 $3
