/*
|	Program: Stored Functions 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Stored Functions		--;
prompt ---------------------------------------------------;
prompt -- resuable program and it should return one value;
prompt -- WIth OUT parameter we can output multiple values;
prompt -- return null when no value is returning;
prompt ---------------------------------------------------;

CREATE OR REPLACE FUNCTION sf_get_employee_name 
(
	p_empnum IN NUMBER
)
RETURN VARCHAR
IS
	l_name	VARCHAR2(20);
BEGIN
	SELECT employee_name INTO l_name
	FROM employees 
	WHERE employee_id = p_empnum;
	RETURN l_name;
END;
/


prompt ---------------------------------------------------;
prompt 		Unit testing				--;
prompt ---------------------------------------------------;

DECLARE 
	l_empname	VARCHAR2(30);
BEGIN
	l_empname := sf_get_employee_name(7788);
	DBMS_OUTPUT.put_line(l_empname);
END;
/


prompt ---------------------------------------------------;
prompt -- RERURN multiples values from function		--;
prompt ---------------------------------------------------;

CREATE OR REPLACE FUNCTION sf_get_multiple_values
(
	p_empnu	IN NUMBER,
	p_ename	OUT VARCHAR2,
	p_job	OUT VARCHAR2
)
RETURN NUMBER
IS
	l_emp_num NUMBER;
BEGIN
	SELECT employee_name, job, salary INTO p_ename, p_job, l_emp_num
	FROM employees
	WHERE employee_id = p_empnu;
	RETURN l_emp_num;
END;
/

prompt ---------------------------------------------------;
prompt 		Unit testing for Multiple values 	--;
prompt ---------------------------------------------------;

DECLARE 
	v0 	NUMBER;
	v1	VARCHAR2(20);
	v2	VARCHAR2(20);
BEGIN
	v0 := sf_get_multiple_values(7788, v1, v2);
	DBMS_OUTPUT.put_line(v0|| ' - '|| v1 || ' - '||v2);
END;
/
