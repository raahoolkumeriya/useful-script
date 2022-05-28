SET SERVEROUTPUT ON;

DECLARE
	-- define a boolean variable
	l_bool BOOLEAN;
BEGIN
	-- use an NVL function to substitute a value for evaluation
	IF NOT NVL(l_bool, FALSE) THEN
		dbms_output.put_line('This should happen!!');
	ELSE
		dbms_output.put_line('This can''t happen!!');
	END IF;
END;
/
