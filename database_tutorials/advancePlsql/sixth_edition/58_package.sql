/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: Package 
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
prompt 			Package 			  ;
prompt ---------------------------------------------------;

--- Package implmentation 
create or replace PACKAGE employee_pkg 
	AUTHID DEFINER
IS
	
	SUBTYPE fullname_t IS VARCHAR2(200);

	FUNCTION fullname( last_in  HR.employees.last_name%TYPE,
			   first_in HR.employees.first_name%TYPE)
		RETURN fullname_t;

	FUNCTION fullname ( employee_id_in IN HR.employees.employee_id%TYPE)
		RETURN fullname_t;

end employee_pkg;
/ 

show error;


-- package body

create or replace package body employee_pkg
AS
	FUNCTION fullname( last_in  HR.employees.last_name%TYPE,
                           first_in HR.employees.first_name%TYPE)
                RETURN fullname_t
	IS
	BEGIN
		RETURN last_in || ',' || first_in;
	END;

	FUNCTION fullname ( employee_id_in IN HR.employees.employee_id%TYPE)
                RETURN fullname_t
	IS
		retval	fullname_t;
	BEGIN
		SELECT fullname (last_name, first_name) INTO retval
			FROM HR.employees
		   WHERE employee_id = employee_id_in;
		RETURN retval;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN RETURN NULL;
		WHEN TOO_MANY_ROWS THEN RETURN NULL;
	END;

end employee_pkg;
/


SHO ERR;


prompt ----------------------------------------------;

DECLARE
	l_name employee_pkg.fullname_t;
	employee_id_in  HR.employees.employee_id%TYPE := 100;
BEGIN
	l_name := employee_pkg.fullname(employee_id_in);
	DBMS_OUTPUT.puT_line(l_name);
END;
/


