/*
||	Program: DUAL vs xdual 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		dual vs xdual			--;
prompt ---------------------------------------------------;

prompt ----- on DUAL TABLE ------;
DECLARE 
	x NUMBER;
BEGIN
	FOR i IN 1..10000 LOOP
		SELECT 1 INTO x FROM DUAL;
	END LOOP;
END;
/

prompt ----- on xDUAL TABLE ------;
DECLARE 
	x NUMBER;
BEGIN
	FOR i IN 1..10000 LOOP
		SELECT 1 INTO x FROM xDUAL;
	END LOOP;
END;
/
