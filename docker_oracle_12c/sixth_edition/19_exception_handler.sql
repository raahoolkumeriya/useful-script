SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE delete_employee ( employee_id_in IN NUMBER)
IS
	-- declare teh exception
	still_have_employees EXCEPTION;
	
	-- Associate the exception name with the an error number
	PRAGMA EXCEPTION_INIT ( still_have_employees, -2292);

BEGIN
	-- try to delete the company 
	DELETE FROM employee_details
	  WHERE EMPNO = employee_id_in;
EXCEPTION
	-- If Child record were found, this exception is raised!
	WHEN still_have_employees
	THEN
		DBMS_OUTPUT.PUT_LINE('Please delete employees for Company first.');
END;
/

show errors;

EXECUTE delete_employee ( 7001);

