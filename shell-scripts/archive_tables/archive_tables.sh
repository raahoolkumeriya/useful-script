#!/bin/bash

#-------------------------------------------------------
# __change_log__
#   06DEC2021       CODELOCKED  Initial version
# __execution__
#   ./archive_tables.sh
# __support_file__
#   list_of_tables.txt: List of tables to be archived
#                       "Schema.Table" will be header
#-------------------------------------------------------


# Variables to be set
SCRIPT_DIR=$PWD
TABLE_LIST=$SCRIPT_DIR/list_of_tables.txt
CURRENT_DATE=$(date +%d%b%Y)
# ONE_WEEK_AGO=$(date -d "7 days ago" +%d%b%Y)
ONE_WEEK_AGO=$(python -c "import datetime as dt; print((dt.datetime.today() - dt.timedelta(days=7)).date().strftime('%d%b%Y'))")

# Create log Directory
if [[ ! -d $SCRIPT_DIR/LOGS ]]; then
    mkdir $SCRIPT_DIR/LOGS
fi

SCRIPT_LOG=$SCRIPT_DIR/LOGS/archive_tables_$(date +%d%m%y%H%M%S).log

log(){
    echo "[$(date '+%d-%m-%Y %H:%M:%S')]: $@" | tee -a $SCRIPT_LOG
}

validate_file_existance(){
    if [ ! -f $1 ]; then
        log "File $1 does not exist"
        exit 1
    fi
}


# Loading environment variables
ENV_FILE=$(find $SCRIPT_DIR -name "*.env" 2>/dev/null)

validate_file_existance $ENV_FILE
validate_file_existance $TABLE_LIST

source $ENV_FILE >/dev/null 2>&1

echo "Log file: $SCRIPT_LOG"

log "------ Archiving tables ------"
log " Script Directory: $SCRIPT_DIR"
log " Current Date: $CURRENT_DATE"
log " List of tables: $TABLE_LIST"
log " One week ago: $ONE_WEEK_AGO"
log "--------------------------------"

# function check for header and records of files
file_validation(){
    if [[ $(head -n 1 $1 | grep -c "Schema.Table") -eq 0 ]]; then
        log "File $1 does not have header"
        exit 1
    fi
    if [[ $(wc -l $1 | awk '{print $1}') -eq 1 ]]; then
        log "File $1 does not have any records"
        exit 1
    fi
}

connect_database(){
    log "Connecting to database $ORAUSER $TNSNAME"
    OLD_BACKUP_TABLE=${2}_${ONE_WEEK_AGO}
    NEW_BACKUP_TABLE=${2}_${CURRENT_DATE}

    log "------- TABLE SUMMARY ---------"
    log " Original Table : ${1}.${2}"
    log " OLD Backup Table : ${1}.${OLD_BACKUP_TABLE}"
    log " NEW Backup Table : ${1}.${NEW_BACKUP_TABLE}"
    log "---------------------------------"

$ORACLE_HOME/bin/sqlplus -s $ORAUSER/$ORAPWD@$TNSNAME <<-EOF >> $SCRIPT_LOG 2>&1
WHENEVER OSERROR EXIT 9;
WHENEVER SQLERROR EXIT SQL.SQLCODE;
conn $ORAUSER/$ORAPWD@$TNSNAME
set linesize 1000;
set pagesize 1000;
set null 'NULL';
set underline off;
set colsep ',';
set heading ON;
set serveroutput on size 1000000;
set echo on;

DECLARE
    v_table_exist NLS_NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_table_exist FROM DBA_TABLES WHERE OWNER = UPPER('$1') AND TABLE_NAME = UPPER('$2');
    IF v_table_exist = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Table does not exist');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Table exists');
        EXECUTE IMMEDIATE 'DROP TABLE $1.$OLD_BACKUP_TABLE';
        DBMS_OUTPUT.PUT_LINE('Table dropped');
        DBMS_OUTPUT.PUT_LINE('Creating backup table');
        EXECUTE IMMEDIATE 'CREATE TABLE $1.$NEW_BACKUP_TABLE AS SELECT * FROM $1.$2';
    END IF;
END;
/
EOF

SQL_RETURN=$?

if [[ $SQL_RETURN -ne 0 ]]; then
    log "Error while executing SQL"
    exit 1
else 
    log "SQL executed successfully"
fi

}

file_validation $TABLE_LIST
# looping for each table
for row in $(sed '1d' $TABLE_LIST); do
    TABLE_SCHEMA=$(echo $row | awk -F. '{print $1}')
    TABLE_NAME=$(echo $row | awk -F. '{print $2}')
    connect_database $TABLE_SCHEMA $TABLE_NAME
done

log "INFO: Deleting old backup files"
find $SCRIPT_DIR/LOGS -name "*.log" -mtime +7 -exec rm {} \;

