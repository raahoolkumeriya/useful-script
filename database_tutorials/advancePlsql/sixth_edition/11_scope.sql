SET SERVEROUTPUT ON;

EXEC scope_demo.set_global(10);

show errors;

BEGIN
	DBMS_OUTPUT.PUT_LINE(scope_demo.g_global);
END;
/

	
