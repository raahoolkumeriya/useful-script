SET SERVEROUTPUT ON;

BEGIN
	FOR i IN 1..10 LOOP
		dbms_output.put_line('The index value is ['||i||']');
	END LOOP;
END;
/

prompt "Explicit cursor in a FOR loop"

DECLARE
	CURSOR c IS SELECT table_name FROM all_tables WHERE table_name LIKE '%MAP';
BEGIN
	FOR i IN c LOOP
		dbms_output.put_line('The title is ['||i.table_name||']');
	END LOOP;
END;
/


prompt "Implicit cursor in a FOR loop"
BEGIN
	FOR i IN (SELECT table_name FROM all_tables WHERE table_name like '%MAP') LOOP
		dbms_output.put_line('The title is ['||i.table_name||']');
	END LOOP;
END;
/
		
