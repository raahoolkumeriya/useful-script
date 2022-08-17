/*
||	Program: Best Practise to check OPEN MODE of Pluggable database  
||	Author: codelocked
||	Change history:
||		27-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- 	OPEN MODE of Pluggable database		--;
prompt ---------------------------------------------------;

COLUMN name FORMAT a10;
COLUMN open_mode FORMAT a10;

SELECT name, open_mode FROM v$pdbs;

prompt ---------------------------------------------------;
prompt --  		Check PDB ? or CDB ?;
prompt ---------------------------------------------------;

SELECT name, CDB FROM v$database;

SELECT name, log_mode, open_mode, CDB FROM v$database;


prompt ---------------------------------------------------;
prompt --  	Save state of Plugglable database	--;
prompt ---------------------------------------------------;

prompt ALTER PLUGGABLE DATABASE orclpdb1 OPEN;
prompt ALTER PLUGGABLE DATABASE orclpdb1 SAVE STATE;


prompt ---------------------------------------------------;
prompt --  	CLOSE the Plugglable database		--;
prompt ---------------------------------------------------;

prompt ALTER PLUGGABLE DATABASE orclpdb1 CLOSE;
prompt --- CLOSE ALl pluggable databases --;
prompt ALTER PLUGGABLE DATABASE all CLOSE;

prompt ---------------------------------------------------;
prompt --  	OPEN Plugglable database		--;
prompt ---------------------------------------------------;

prompt ALTER PLUGGABLE DATABASE all OPEN;
prompt ALTER PLUGGABLE DATABASE orclpdb1 OPEN;

prompt ---------------------------------------------------;
prompt --  	Create common user in database		--;
prompt ---------------------------------------------------;

prompt CREATE USER c##userName01 INDENTIFIED BY Password01 CONTAINER = all;
prompt GRANT CREATE Session to c##userName01;


