/*
|	Program: PL/SQL Tips and Techniques 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';
/

CREATE OR REPLACE PROCEDURE plw6002 AUTHID DEFINER
AS
	l_checking	BOOLEAN := FALSE;

	PROCEDURE why_did_i_write_this
	IS 
	BEGIN
		DBMS_OUTPUT.put_line('Why did i write this?');
	END;
BEGIN
	NULL;
	IF l_checking THEN
		DBMS_OUTPUT.put_line('Never here...');
	ELSE
		DBMS_OUTPUT.put_line('Always here...');
		GOTO end_of_function;
	END IF;

	<<end_of_function>>
	c 	VARCHAR2(1) := 'abc';
	n	NUMBER;
BEGIN
	n := 1/0;
END;
/

SHO ERR;

BEGIN plw6017; END;

