/*
||	Program: Connect DB and grant roles   
||	Author: Raahool Kumeriya
||	Change history:
||		15-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     	Connect DB and grant roles		--;
prompt ---------------------------------------------------;

SET HEADING OFF;
SET FEEDBACK OFF;
SET VERIFY OFF;
SET TIMING OFF;


spool /var/tmp/result.sql

SELECT 'GRANT SELECT ON '||table_name||' TO NEW_USER;' FROM USER_TABLES;

SPOOL OFF;

/*
spool /var/tmp/execution.log
@/var/tmp/result.sql;
spool off;
*/


