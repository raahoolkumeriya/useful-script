SET SERVEROUTPUT ON;

DECLARE
	l_variable VARCHAR2(10);
BEGIN
	l_variable := '&input';
	dbms_output.put_line(l_variable);
EXCEPTION
	WHEN others THEN
		dbms_output.put_line(SQLERRM);
END;
/
