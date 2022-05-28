SET SERVEROUTPUT ON;
SET TIMING ON;

--------- Declaration of anonymonus PLSQL block -------
DECLARE
	l_emp_count INTEGER;
-------- Declaration end here -------------------------

-------- BEGIN word marks the start of execution section ----
BEGIN
	SELECT COUNT(*)
		INTO l_emp_count
		FROM employees;
-------- DBMS_OUTPUT.PUT_LINE built-in procedure to display ---
	DBMS_OUTPUT.PUT_LINE(
		'Employee table has '||
		l_emp_count|| 
		' employees.');
END;
/
