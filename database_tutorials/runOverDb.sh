#!/bin/bash
#
# Since April 2022
# Author: CODELOCKED
# Description: Generate Flat files from Oracle Database
#
# Change_logs
#       06-APR-2022     CODELOCKED      Initial Draft version of Script
#       12-APR-2022     CODELOCKED      Database Connection, SFTP, Mode selection
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#
# Copyright (c) 2022 Codelocked and/or its affiliates.
#

usage() {
  cat << EOF

Usage: $(basename $0) -mode [hr|sys|axiomus]
Database connection Script with different users

Parameters:
   -mode: (Optional) mode of choosing users
            hr 		: HR Schema/Users
            sys		: SYS User
	    axomus	: axiomus Schema/user
   -query: (required) database query file

Execution:
        Default mode: (for User axiomus)
                bash $(basename $0) -q <query_file>
        HR mode:
                bash $(basename $0) -mode hr -query <query_file>
        SYSDBA mode:
                bash $(basename $0) -mode sys -q <query_file>

License: LICENSE GNU 1.0

Copyright (c) 2022, CODELOCKED and/or its affiliates.

EOF

}

# Log function
log() {
  echo "[$(date +"%y-%m-%d %H:%M:%S")]: $@" >> $LOG_FILE
}

connectDatabase(){
    # Function connect to database
    # Parameters:
    #   $1: <Query File Name>
    #   $2: <Query File Name>
    #   $3: <Mode>

    case $1 in
       "axiomus")
           sqlplus -s "/nolog" <<EOF>>$LOG_FILE 
    	   WHENEVER OSERROR EXIT 9;
    	   WHENEVER SQLERROR EXIT SQL.SQLCODE;
	   conn ${ORAUSER}/${ORAPASS}@${TNSMAIN}
           @$2 $3;
           exit;
EOF
            ;;
      "hr")
           sqlplus -s "/nolog" <<EOF>>$LOG_FILE 
    	   WHENEVER OSERROR EXIT 9;
    	   WHENEVER SQLERROR EXIT SQL.SQLCODE;
           conn HR/HR@${TNSMAIN}
           @$2 $3;
           exit;
EOF
            ;;
      "sys")
           sqlplus -s "/nolog" <<EOF>>$LOG_FILE 
    	   WHENEVER OSERROR EXIT 9;
    	   WHENEVER SQLERROR EXIT SQL.SQLCODE;
           conn SYS/Oradoc_db1@${TNSMAIN} AS SYSDBA
           @$2 $3;
           exit;
EOF
    esac

    export SQL_ERR=$?
    if [ $SQL_ERR -ne 0 ]; then
        log "SQLERROR: Query error $SQL_ERR in $(basename $2)" 
    fi
}


#################
###  M A I N  ###
#################

declare -l DB_USER

# Variables declaration
SCRIPT_DIR=$PWD
ENV_FILE=$HOME/lima_env.conf
# Hardcoded Default User mode
DB_USER=axiomus

source $ENV_FILE 2>/dev/null

if [[ $# -gt 4 ]]; then
  usage
  exit 1
else
    while [[ $# -ne 0 ]] ; do
        case "$1" in
            -mode)
                DB_USER=$2
                shift 2
                ;;
            -query|-q)
                QUERY_FILE=$2
                shift 2
                ;;
            -*)
                echo "Unknown option: $1"
                usage
                exit 1
                ;;
            *)
                break
                ;;
        esac
    done
fi

if [[ -z $QUERY_FILE ]]; then
      usage
      exit 1;
fi

# Log File construnction
QUERY_DIR=$SCRIPT_DIR/$(dirname $QUERY_FILE)
LOG_DIR=$(basename $QUERY_DIR)
# LOG_FILE=$SCRIPT_DIR/${LOG_DIR}/LOGS_${LOG_DIR^^}/$(basename $0 .sh)_$(basename $QUERY_FILE .sql)_$(date +%d%m%y%H%M%S).log
LOG_FILE=$SCRIPT_DIR/${LOG_DIR}/LOGS_${LOG_DIR^^}/$(basename $QUERY_FILE .sql)_$(date +%d%m%y%H%M%S).log


# Create Log Directory
if [ ! -d $SCRIPT_DIR/${LOG_DIR}/LOGS_${LOG_DIR^^} ]; then
  mkdir $SCRIPT_DIR/${LOG_DIR}/LOGS_${LOG_DIR^^}
fi

log "INFO: Log File name: $LOG_FILE"
(umask 0; touch $LOG_FILE)

log "INFO: Starting the script"
log "INFO: Script Directory: $SCRIPT_DIR"
log "INFO: Query Directory: $QUERY_DIR"
log "INFO: Spinning Connection with ${DB_USER^^}@$TNSMAIN"
log "+---------------------------------+"
log "| database query execution begins |"
log "+---------------------------------+"

connectDatabase ${DB_USER} ${QUERY_DIR}/$(basename $QUERY_FILE)

log "+---------------------------------+"
log "|     database query ends here    |"
log "+---------------------------------+"

echo "---------------------------------------------------"
echo -e "\t\t D E T A I L S - L O G S "
echo "---------------------------------------------------"
cat $LOG_FILE
echo "---------------------------------------------------"
echo -e "\t\t L O G S - E N D S "
echo "---------------------------------------------------"

