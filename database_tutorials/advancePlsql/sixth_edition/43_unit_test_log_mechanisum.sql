/*
||	Program: TEST log mechnisum 
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
prompt --     		TEST log mechnisum		--;
prompt ---------------------------------------------------;

COL TEXT FORMAT A50;
COL CREATED_BY  FORMAT A10;
COL CHANGED_BY FORMAT A10;

SELECT * FROM logtab;

COL OBJECT_NAME FORMAT A30;
COL OBJECT_TYPE FORMAT A20;
COL STATUS FORMAT A20;
SELECT OBJECT_NAME,OBJECT_TYPE,STATUS 
FROM USER_OBJECTS WHERE OBJECT_TYPE='PACKAGE' AND OBJECT_NAME='LOG';

DECLARE
	l_result NUMBER;
BEGIN
	l_result := 1 / 0;
EXCEPTION 
	WHEN ZERO_DIVIDE THEN
		axiomus.log.saveline(SQLCODE, SQLERRM);
END;
/
	
SELECT * FROM logtab;
