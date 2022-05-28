SET SERVEROUTPUT ON;

--- package specification
CREATE OR REPLACE PACKAGE scope_demo
IS
/*
|	Program: scope_demo
|	Author: Raahool Kumeriya
|	Change history:
|		06-MAY-2022 Scope demo package
|		05-MAY-2022 - Program Created
|*/
	g_global 	NUMBER;
	PROCEDURE	set_global (number_in IN NUMBER);
END scope_demo;
/

-- body 
CREATE OR REPLACE PACKAGE BODY scope_demo
IS
	PROCEDURE set_global ( number_in IN NUMBER)
	IS
		l_salary 	NUMBER := 10000;
		l_count 	PLS_INTEGER;
	BEGIN
		<<local_block>>
		DECLARE
			l_inner	NUMBER;
		BEGIN
			SELECT COUNT(*)
			  INTO l_count
			  FROM employees
			WHERE employee_id = l_inner AND salary > l_salary;
		END local_block;

		g_global := number_in;
	END set_global;
END scope_demo;
/

show errors



