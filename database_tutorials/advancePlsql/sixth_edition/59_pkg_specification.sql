/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: Package Specification 
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
prompt 		Package Specification			  ; 
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE employees_pkg 
	AUTHID CURRENT_USER
IS /* or AS */
	
	-- Two constants; notice that I give understandable
	-- 	names to otherwise obscure values.

	c_ceo CONSTANT PLS_INTEGER := 100;
	c_cto CONSTANT PLS_INTEGER := 101;

	-- A nested table TYPE declaration.
	TYPE emp_ids_nt IS TABLE OF INTEGER;

	-- A nested table declared from the generic type.
	my_employees emp_ids_nt;

	-- A REF CURSOR returning favorites information.
	TYPE emp_info_rct IS REF CURSOR RETURN HR.employees%ROWTYPE;

	--  A procedure that accepts a list of employees
	-- (using a type defined above ) and display the 
	-- favorite information form that list.
	PROCEDURE show_employees (list_in IN emp_ids_nt );

	-- A function that returns all teh information on 
	-- employees table about the it
	FUNCTION employee_detail RETURN emp_info_rct;

END employees_pkg;
/

sho err;
