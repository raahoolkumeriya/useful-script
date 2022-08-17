#!/bin/bash

SCRIPT_DIR=/u01/advancePlsql
ENV_FILE=$SCRIPT_DIR/environment.conf

source $ENV_FILE 2>/dev/null

$ORACLE_HOME/bin/exp ${ORAUSER}/${ORAPASS}@${TNSMAIN} tables='employees' file="$PWD/table_dumps.dmp"

echo "End of Script"
 
