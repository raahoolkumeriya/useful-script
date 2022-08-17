/*
||	Program: Enable and Disable Flashback  
||	Author: codelocked
||	Change history:
||		27-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	Enable and Disable Flashback		--;
prompt ---------------------------------------------------;
prompt -- Enable flashback --;
ALTER DATABASE flashback ON;

SELECT flashback_on FROM v$database;

prompt -- Disable flashback --;
ALTER DATABSE flashback OFF;

SELECT flashback_on FROM v$database;


