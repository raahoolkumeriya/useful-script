/*
|	Program: REF Cursor 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		REF Cursor			--;
prompt ---------------------------------------------------;


DECLARE
	TYPE c_ref IS REF CURSOR;		-- Declare a REF cursor type
	cur c_ref;				-- Declare a cursor vaiable of ref cursor type
	l_ename	employees.employee_name%TYPE;
	l_sal	employees.salary%TYPE;
	l_deptno departments.department_id%TYPE;
	l_deptname departments.department_name%TYPE;
BEGIN
	OPEN cur FOR 
		SELECT employee_name, salary 
		FROM employees
		WHERE employee_id = 7788;
	FETCH cur INTO l_ename, l_sal;
	CLOSE cur;
	DBMS_OUTPUT.PUT_LINE('Salary of '||l_ename||' is '||l_sal);

	-- Reopen the cursor varaible for second SELECT statments
	OPEN cur FOR 
		SELECT department_id, department_name
		FROM departments
		WHERE location = 'Mumbai';
	FETCH cur INTO l_deptno, l_deptname;
	CLOSE cur;

	DBMS_OUTPUT.PUT_LINE('Department name '||l_deptname||' for '||l_deptno);
END;
/


