/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: Package body
|
|	Change history:
|	Date		Who		Description
|	----------	----------	-----------------------------------
|	29-JUN-22  	codelocked	Program Created
|
+ - - - */

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			Package body			  ; 
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE body employees_pkg 
IS /* or AS */
	
	-- A provate variable
	g_ceo	PLS_INTEGER := c_ceo;

	-- Implmentation of the function
	FUNCTION employee_detail RETURN emp_info_rct
	IS
		retval emp_info_rct;
		null_cv emp_info_rct;
	BEGIN
		OPEN retval FOR SELECT * FROM HR.employees 
			WHERE employee_id = g_ceo;
		RETURN retval;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN RETURN null_cv;
	END employee_detail;

	-- Implmentation of Prcedure
	PROCEDURE show_employees (list_in IN emp_ids_nt )
	IS
	BEGIN
		FOR indx IN list_in.FIRST .. list_in.LAST
		LOOP
			DBMS_OUTPUT.put_line(list_in(indx));
		END LOOP;
	END show_employees;


END employees_pkg;
/

sho err;
