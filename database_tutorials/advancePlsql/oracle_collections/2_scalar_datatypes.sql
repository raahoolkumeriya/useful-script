/*
|	Program: Scalar Data typoes 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;


DECLARE
	v_emp_name	VARCHAR2(10);
	v_emp_sal	NUMBER;
BEGIN
	SELECT employee_name, salary
	INTO 	v_emp_name,v_emp_sal
	FROM employees 
	WHERE employee_id = 7788;
	
	dbms_output.put_line('Employee name : '||v_emp_name);
	dbms_output.put_line('Employee salary : '||v_emp_sal);
END;
/

