/*
|	Program: %ROWTYPE
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

select * from employees;

prompt -----------------------------------------------------;
prompt -- 		%ROWTYPE Attribute		  --;
prompt -----------------------------------------------------;
prompt It let you declare a record that represent a row in a table or view;
prompt the record has a field with the smae name and data type.;

DECLARE
	v_emp_rec	employees%ROWTYPE;
BEGIN
	SELECT *
	INTO v_emp_rec
	FROM employees
	WHERE employee_id = 7788;

	dbms_output.put_line('Employee name = '||v_emp_rec.employee_name);
	dbms_output.put_line('Employee Salary = '||v_emp_rec.salary);
END;
/

prompt ---------------------------------------------------;
prompt using record variabel in insert statement;
prompt ---------------------------------------------------;

CREATE table employee_backup AS
	SELECT * FROM employees WHERE 1=2;

DECLARE
	v_emp_rec	employees%ROWTYPE;
BEGIN
	SELECT * 
	INTO v_emp_rec
	FROM employees
	WHERE employee_id = 7788;
	
	INSERT INTO employee_backup values v_emp_rec;


	v_emp_rec.salary := v_emp_rec.salary + 1000;
	v_emp_rec.department_id := 50;

	UPDATE employee_backup 
	SET row = v_emp_rec	
	WHERE employee_id = 7788;

END;
/

SELECT * FROM employee_backup;


prompt ---------------------------------------------------;
prompt rowtype variable of cursor ;
prompt ---------------------------------------------------;

DECLARE
	CURSOR cur IS SELECT employee_id, employee_name, salary
		FROM employees;
	lv_emp_rec cur%ROWTYPE;
BEGIN
	OPEN cur;
	FETCH cur INTO lv_emp_rec;
	CLOSE cur;

	dbms_output.put_line('Empolyee id = '||lv_emp_rec.employee_id);
	dbms_output.put_line('Empolyee id = '||lv_emp_rec.employee_name);
	dbms_output.put_line('Empolyee id = '||lv_emp_rec.salary);
END;
/

