/*
|	Program: Predefined Inquiry Directives $$PLSQL_LINE and $$PLSQL_UNIT 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -----------------------------------------------------------------;
prompt -- Predefined Inquiry Directives $$PLSQL_LINE and $$PLSQL_UNIT --;
prompt -----------------------------------------------------------------;

CREATE OR REPLACE PROCEDURE p 
IS
	i PLS_INTEGER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inside P');
	i := $$PLSQL_LINE;
	DBMS_OUTPUT.PUT_LINE('i = '||i);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_LINE = '|| $$PLSQL_LINE);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_UNIT = '|| $$PLSQL_UNIT);

END;
/

	
BEGIN
	p;
	DBMS_OUTPUT.PUT_LINE('Outside p');
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_UNIT = '|| $$PLSQL_UNIT);
END;
/

prompt -----------------------------------------------------------------;
prompt -- Displaying Values of PL/SQL Compilation Parameters	      --;
prompt -----------------------------------------------------------------;

BEGIN
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_SETTINGS = '	|| $$PLSQL_SETTINGS);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_CCFLAGS = '	|| $$PLSQL_CCFLAGS);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_CODE_TYPE = '	|| $$PLSQL_CODE_TYPE);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_OPTIMIZE_LEVEL = '|| $$PLSQL_OPTIMIZE_LEVEL);
	DBMS_OUTPUT.PUT_LINE('$$PLSQL_WARNINGS = '	|| $$PLSQL_WARNINGS);
	DBMS_OUTPUT.PUT_LINE('$$NLS_LENGTH_SEMANTICS = '|| $$NLS_LENGTH_SEMANTICS);
END;
/
