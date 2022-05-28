SET SERVEROUTPUT ON;

DECLARE
	l_variable NUMBER(3) := 1;
BEGIN
	l_variable := 3;
	dbms_output.put_line('Variable value : '|| l_variable);
END;
/


DECLARE
	l_var VARCHAR2(10);
BEGIN
	l_var := '#';
	dbms_output.put_line('Variable value : '|| l_var);
	
END;
/


DECLARE
	l_default NUMBER DEFAULT 10;
BEGIN
	dbms_output.put_line('Default value : '||l_default);
END;
/	
