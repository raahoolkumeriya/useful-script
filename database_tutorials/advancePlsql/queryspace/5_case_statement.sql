SET SERVEROUTPUT ON;

BEGIN
	CASE TRUE
		WHEN (1 > 3) THEN
			dbms_output.put_line('One is greater then three.');
		WHEN (3 < 5) THEN
			dbms_output.put_line('Three is less then five.');
		WHEN ( 1 = 2) THEN
			dbms_output.put_line('One equal to two.');
		ELSE
			dbms_output.put_line('Nothing else.');
	END CASE;
END;
/	
