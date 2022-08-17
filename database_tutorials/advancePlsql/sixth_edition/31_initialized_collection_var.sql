/*
||	Program: Declaring and Initializing Collection Variables  
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt Declaring and Initializing Collection Variables  --;
prompt ---------------------------------------------------;
prompt o Associate Array o;

DECLARE 
	TYPE employees_aat IS TABLE OF employees%ROWTYPE INDEX BY PLS_INTEGER;
	player_list employees_aat;
	judge_list  employees_aat;
BEGIN
	NULL;
END;
/

 
prompt o Declartion and Initialized of NESTED TABLE or VARRAY  o;
DECLARE
	TYPE employee_nnt IS TABLE OF employees%ROWTYPE;
	player_list employee_nnt := employee_nnt();
BEGIN
	NULL;
END;
/

prompt o Declartion, Initialized in execution section o;
DECLARE
	TYPE employee_nnt IS TABLE OF employees%ROWTYPE;
	player_list employee_nnt;
BEGIN
	player_list := employee_nnt();
END;
/


prompt ---------------------------------------------------;
prompt --   Assigning rows from a relational table	--;
prompt ---------------------------------------------------;

DECLARE
	TYPE emp_copy_nnt IS TABLE OF employees%ROWTYPE;
	l_emps emp_copy_nnt := emp_copy_nnt();
BEGIN
	l_emps.EXTEND;
	SELECT * 
	INTO l_emps(1)	
	FROM employees
	WHERE employee_id = 7788;
	DBMS_OUTPUT.put_line(l_emps(1).employee_name
				|| 'has salary of '
				||l_emps(1).salary);
END;
/

prompt ---------------------------------------------------;
prompt Cursor for loop for multiple rows into collection -;
prompt ---------------------------------------------------;

DECLARE
	TYPE employee_nnt IS TABLE OF employees%ROWTYPE;
	l_emps employee_nnt := employee_nnt();
BEGIN
	FOR emp_rec IN ( SELECT * FROM employees )
	LOOP
		l_emps.EXTEND;
		l_emps(l_emps.LAST) := emp_rec;
		DBMS_OUTPUT.put_line(l_emps(l_emps.LAST).employee_name);
	END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt 		BULK collect to dump into collection 	--;
prompt ---------------------------------------------------;

DECLARE
	TYPE employees_ntt IS TABLE OF employees%ROWTYPE;
	l_emps employees_ntt;
BEGIN
	SELECT * BULK COLLECT INTO l_emps FROM employees;
END;
/

