#!/bin/bash

LOG_FILE=test_module_pmon_status.log

echo "+---------------------+" > $LOG_FILE
echo "| Exists PMON process |" >> $LOG_FILE
echo "+---------------------+" >> $LOG_FILE

ansible-playbook test_module_pmon_status.yml -e 'database_instance=SBCDB user=raahool remote_host=node' >> $LOG_FILE

echo "" >> $LOG_FILE
echo "+-----------------+" >> $LOG_FILE
echo "| No PMON process |" >> $LOG_FILE
echo "+-----------------+" >> $LOG_FILE

ansible-playbook test_module_pmon_status.yml -e 'database_instance=NYCDB1 user=raahool remote_host=node' >> $LOG_FILE

echo "" >> $LOG_FILE
