/*
||	Program: Database 
||	Author: codelocked
||	Change history:
||		22-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --		Check Database			--;
prompt ---------------------------------------------------;

COL database_name FORMAT A25;
COL file_name FOR A60;

SELECT database_name, open_mode FROM v$database;

SELECT tablespace_name, file_name from dba_data_files;


prompt ---------------------------------------------------;
prompt --		Show parameters			--;
prompt ---------------------------------------------------;

SHOW parameter db_name;

show parameter controlfile;

show parameter background;

show parameter db;

prompt ---------------------------------------------------;
prompt --		Instance Status			--;
prompt ---------------------------------------------------;

SELECT status FROM v$instance;

SELECT name from v$datafile;


