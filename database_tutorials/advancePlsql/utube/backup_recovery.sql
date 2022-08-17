/*
|	Program: BACKUP and Recovery 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     	BACKUP and Recovery 			--;
prompt ---------------------------------------------------;
prompt -- Two Types of backup:;
prompt o Physical Backup (physcially copying file from one location to other;
prompt -----> Hot backup --> when database is active while taking backup; 
prompt -----> Cold backup --> database is down while doing backup; 
prompt ---------> cp command and RMAN - recovery manager;
prompt 
prompt o Logical backup;
prompt backing up Db objects (tables.views/...);
prompt --> database need to active while doing backup;
prompt --->o traditional Backup;
promtp --------> Import and export 
prompt --->o datadump 

prompt ---------------------------------------------------;
prompt Traditional Backup (import and export );
prompt ---------------------------------------------------;
prompt For Export table data run shell script tradition_backup.sh;

drop table employees;

prompt For import table data run shell script import_table.sh;

Select * from employees;
 
