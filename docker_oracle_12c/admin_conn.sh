#!/bin/bash
#
# Since April 2022
# Author: CODELOCKED
# Description: Execute query on Oracle Database
#
# Change_logs
#       06-APR-2022     CODELOCKED      Initial Draft version of Script
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#
# Copyright (c) 2022 Codelocked and/or its affiliates.
#

usage() {
  cat << EOF

Usage: $(basename $0) <Query_file_name>

LICENSE GNU 1.0

Copyright (c) 2022, CODELOCKED and/or its affiliates.

EOF
}

# Log function
log() {
  echo "[$(date +"%y-%m-%d %H:%M:%S")]: $@" >> $LOG_FILE
}

# Database connection function
connectDatabase(){
    # Function connect to database
    # Parameters:
    #   $1: <Query File Name>
    #   $2: <Mode>

    $ORACLE_HOME/bin/sqlplus -s / as sysdba@$TNSMAIN <<-EOF>>$LOG_FILE
    @$1 $2;
    exit;
EOF

    export SQL_ERR=$?
    if [ $SQL_ERR -ne 0 ]; then
        log "SQLERROR: Query error $SQL_ERR in $(basename $1)"
    fi
}

#################
###  M A I N  ###
#################

# Variables
SCRIPT_DIR=$PWD
QUERY_DIR=$SCRIPT_DIR/$(dirname $1)
LOG_FILE=$SCRIPT_DIR/LOGS/$(basename $0 .sh)_$(basename $1 .sql)_$(date +%d%m%y%H%M%S).log
ENV_FILE=$SCRIPT_DIR/environment.conf

source $ENV_FILE 2>/dev/null

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

# Create Log Directory
if [ ! -d $SCRIPT_DIR/LOGS ]; then
  mkdir $SCRIPT_DIR/LOGS
fi

log "INFO: Log File name: $LOG_FILE"
(umask 0; touch $LOG_FILE)

log "INFO: Starting the script"
log "INFO: Script Directory: $SCRIPT_DIR"
log "INFO: Query Directory: $QUERY_DIR"
log "INFO: Spinning Connection with $ORAUSER@$TNSMAIN"
log "----------------------------------------------------"
log " DATABASE QUERY STARTS "
log ""

connectDatabase ${QUERY_DIR}/$(basename $1)

echo "---------------------------------------------------"
echo -e "\t\t D E T A I L S - L O G S "
echo "---------------------------------------------------"
cat $LOG_FILE
echo "---------------------------------------------------"
echo -e "\t\t L O G S - E N D S "
echo "---------------------------------------------------"
