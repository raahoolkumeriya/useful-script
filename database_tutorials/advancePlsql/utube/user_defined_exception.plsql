/*
|	Program: USER Defined EXception | PLSQL
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     	USER Defined EXception			--;
prompt ---------------------------------------------------;
prompt - Created by user;
prompt - Begin block ----> varaible of excepition type;
prompt - Declare block ---> Raise exce_name;
prompt - exception block --> exception is handled
prompt ---------------------------------------------------;

DEFINE l_dnum = 7788;

DECLARE
	l_vnum	NUMBER;
	l_dnum	NUMBER;
	test_except	EXCEPTION;

BEGIN
	SELECT salary INTO l_vnum
	FROM employees WHERE employee_id = &l_dnum;
	IF l_vnum < 4500 THEN
		RAISE test_except;
	END IF;
EXCEPTION
	WHEN test_except THEN
		DBMS_OUTPUT.PUT_LINE('The salary is low');
END;
/

