/*
||	Program: grant DBMS_XPLAN access 
||	Author: codelocked
||	Change history:
||		08-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	grant DBMS_XPLAN access			--;
prompt ---------------------------------------------------;

GRANT SELECT ON v_$session TO axiomus;
GRANT SELECT ON v_$sql_plan_statistics_all TO  axiomus;
GRANT SELECT ON v_$sql_plan TO axiomus;
GRANT SELECT ON v_$sql TO axiomus;

