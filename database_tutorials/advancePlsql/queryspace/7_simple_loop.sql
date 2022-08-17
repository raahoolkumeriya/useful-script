SET SERVEROUTPUT ON;

prompt >>>>> SIMPLE CURSOR LOOP <<<<<<<<

DECLARE
	title all_tables.table_name%TYPE;
	CURSOR c IS SELECT table_name FROM all_tables WHERE table_name LIKE '%MAP';
BEGIN
	OPEN c;
	LOOP
		FETCH c INTO title;
		EXIT WHEN c%NOTFOUND;
		dbms_output.put_line('Title of table_name ['||title||']');
	END LOOP;
	CLOSE c;
END;
/


prompt >>>>>>>>> WHILE CURSOR LOOP <<<<<<<<<<

DECLARE
	title all_tables.table_name%TYPE;
	CURSOR c IS SELECT table_name FROM all_tables WHERE table_name LIKE '%MAP';
BEGIN
	OPEN c;
	WHILE c%ISOPEN LOOP
		FETCH c INTO title;
		IF c%NOTFOUND THEN
			CLOSE c;
		END IF;
		dbms_output.put_line('Title of table_name is ['||title||']');
	END LOOP;
END;
/

