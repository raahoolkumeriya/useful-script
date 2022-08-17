/*
|	Program: Composite record type Example 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

DECLARE
	v_emp_rec 	employees%ROWTYPE;
BEGIN
	SELECT * 
	INTO v_emp_rec
	FROM employees
	WHERE employee_id=7788;

	dbms_output.put_line('Employee name : '||v_emp_rec.employee_name);
	dbms_output.put_line('Employee Job : '||v_emp_rec.job);
	dbms_output.put_line('Employee Sal : '||v_emp_rec.salary);
END;
/
