/*
||	Program: Advantage of nonsequential population of collection 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------------;
prompt -- Advantage of nonsequential population of collection --;
prompt ---------------------------------------------------------;

CREATE OR REPLACE PACKAGE justonce 
	AUTHID DEFINER 
IS
	/* eclare a collection type and the collection to hold my cached get_empl_names */
	TYPE emp_names_aat IS
		TABLE OF employees.employee_name%TYPE
			INDEX BY PLS_INTEGER;

	FUNCTION get_empl_name(p_code_in IN employees.employee_id%TYPE)
		RETURN employees.employee_name%TYPE;
END;
/

sho errors;

CREATE OR REPLACE PACKAGE BODY justonce 
IS
	empl_name_aat emp_names_aat;

	FUNCTION get_empl_name(p_code_in IN employees.employee_id%TYPE)
		RETURN employees.employee_name%TYPE
	IS
		FUNCTION name_from_database
			RETURN employees.employee_name%TYPE
		IS
			l_emplname	employees.employee_name%TYPE;
		BEGIN
			SELECT employee_name
			INTO l_emplname
			FROM employees
			WHERE employee_id = p_code_in;
		    RETURN l_emplname;
		END;
	BEGIN
	    RETURN empl_name_aat(p_code_in);
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			empl_name_aat (p_code_in) := name_from_database();
			RETURN empl_name_aat(p_code_in);
	END;
	
END justonce;
/

SHOW ERRORS;

DECLARE
	l_name employees.employee_name%TYPE;
BEGIN
	l_name := justonce.get_empl_name(7788);
	DBMS_OUTPUT.put_line(l_name);
END;
/

