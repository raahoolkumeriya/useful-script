/*
|	Program: Assigning Values to Variables 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --  Assigning Values to Variables                --;
prompt ---------------------------------------------------;
prompt -- With Asignment Statement --;

DECLARE		--You can assign initial value here
	wages		NUMBER;
	hours_worked	NUMBER := 40;
	hourly_salary	NUMBER := 22.50;
	bonus		NUMBER := 150;
	country		VARCHAR2(128);
	counter		NUMBER := 0;
	done 		BOOLEAN;
	valid_id	BOOLEAN;
	emp_rec1	employees%ROWTYPE;
	emp_rec2	employees%ROWTYPE;
	TYPE commission IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
	comm_tab	commission;
BEGIN		-- you can assign values here too
	wages := ( hours_worked * hourly_salary ) + bonus;
	country := UPPER('India');
	done := ( counter > 100 );
	valid_id := TRUE;
	emp_rec1.employee_name := 'Raahool';
	comm_tab(5) := 20000 * 0.15;

	dbms_output.PUT_LINE
		(emp_rec1.employee_name
				||' working in '||country
				||' erans hourly : '||TO_CHAR(wages));
END;
/

prompt -- Assigning Value to Variable with SELECT INTO Statement --;
DECLARE
  bonus   NUMBER(8,2);
BEGIN
  SELECT salary * 0.10 INTO bonus
  FROM employees
  WHERE employee_id = 7788;
	
	DBMS_OUTPUT.PUT_LINE('bonus = ' || TO_CHAR(bonus));
END;
/

prompt --- Assigning Value to Variable as IN OUT Subprogram Parameter ---;

DECLARE
	emp_salary 	NUMBER(8,2);
	
	PROCEDURE adjust_salary (
		emp	NUMBER,
		sal IN OUT NUMBER,
		adjustment NUMBER
	) IS
	BEGIN
		sal := sal + adjustment;
	END;
BEGIN
	SELECT salary INTO emp_salary
	FROM employees
	WHERE employee_id = 7788;
	
	DBMS_OUTPUT.PUT_LINE
		('Before invoking procedure, employee_salary : '|| emp_salary);
	
	adjust_salary(7788, emp_salary, 1000);

	DBMS_OUTPUT.PUT_LINE
		('After invoking procedure, employee_salary : '|| emp_salary);
END;
/
