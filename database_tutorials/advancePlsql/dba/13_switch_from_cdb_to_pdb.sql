/*
||	Program: How to Switch from CDB to PDB 
||	Author: codelocked
||	Change history:
||		27-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	Switch from CDB to PDB			--;
prompt ---------------------------------------------------;

SHOW con_name;

SHOW USER;

COLUMN name FORMAT a10;

SELECT name FROM v$pdbs;

COLUMN open_mode FORMAT a10;

SELECT open_mode FROM v$pdbs
	WHERE name = 'ORCLPDB1';

-- ALTER PLUGGABLE DATABASE orclpdb1 OPEN;

ALTER SESSION SET CONTAINER = ORCLPDB1;

SHOW con_name;


