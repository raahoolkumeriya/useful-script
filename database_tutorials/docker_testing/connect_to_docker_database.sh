#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "usage: $(basename $0) <database_user [HR|AXIOMUS|sysdba|system] >"
	exit 1;
fi

case $1 in 
	"HR"|"hr")

	sqlplus -s HR/HR@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.5.15)(PORT=1521))(CONNECT_DATA = (SERVICE_NAME=ORCLPDB1.localdomain)))'<<EOF
	show user;
EOF

		;;
	
	"AXIOMUS"|"axiomus")
	sqlplus -s AXIOMUS/axiomus123@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.5.15)(PORT=1521))(CONNECT_DATA = (SERVICE_NAME=ORCLPDB1.localdomain)))'<<EOF
	show user;
EOF
	;;
	"SYSTEM"|"system")
	sqlplus -s SYSTEM/Oradoc_db1@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.5.15)(PORT=1521))(CONNECT_DATA = (SERVICE_NAME=ORCLPDB1.localdomain)))'<<EOF
	show user;
EOF
	;;

	*)
		echo "Please username"
esac
