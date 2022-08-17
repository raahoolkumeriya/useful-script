/*
||	Program: Smart Way of Technology | DBA
||		--> Create & grant permission to directory in Oracle
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --Create and grant permission to directory in Oracle--;
prompt ---------------------------------------------------;


prompt --- Create directory in Oracle Database;

Create directory dir_name as '/u01/oracle/';

prompt --- Grant read write permission to Directory;

prompt --grant read permission;
GRANT read on DIRECTORY dir_name to axiomus;
prompt --grant write permission;
GRANT write on DIRECTORY dir_name to axiomus;
prompt -- grant both;
GRANT READ,WRITE ON DIRECTORY dir_Name TO axiomus;

prompt -- Revoke permission from directory;

prompt -- revoke read permission;
REVOKE read on DIRECTORY dir_name FROM axiomus;
prompt -- revoke write permission;
REVOKE write on DIRECTORY dir_name FROM axiomus;
prompt -- revoke both;
-- REVOKE read,write on Directory dir_name from axiomus;

prompt -- Modify path of directory;

create or replace directory dbscript as '/u01/oracle';

create or replace directory dbscript as '/u01/oracle/scripts';

prompt --- Drop the directory;

DROP Directory dbscript;
DROP Directory dir_Name;


