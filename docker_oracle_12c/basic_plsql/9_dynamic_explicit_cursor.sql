prompt Dynamic Explicit Cursors : Accepting local variable

SET SERVEROUTPUT ON;

DECLARE
	table_name_var VARCHAR2(10) := 'DUAL';
	TYPE table_record IS RECORD 
		( table_name VARCHAR2(30)
		, owner	VARCHAR2(10));
	item TABLE_RECORD;
	CURSOR c IS 
		SELECT table_name, owner
		FROM all_tables 
		WHERE table_name = table_name_var;
BEGIN
	OPEN c;
	LOOP
		FETCH c INTO item;
		EXIT WHEN c%NOTFOUND;
		dbms_output.put_line('Items ['||item.table_name||']');
	END LOOP;
	CLOSE c;
END;
/

	

prompt Accept formal parameters 

DECLARE
	table_name_var VARCHAR2(30);
	TYPE item_record IS RECORD
		( table_name VARCHAR2(30)
		, owner VARCHAR2(10));
	item ITEM_RECORD;
	CURSOR c ( tab_name VARCHAR2) IS
		SELECT table_name, owner 
		FROM all_tables
		WHERE table_name LIKE UPPER(tab_name);
BEGIN
	OPEN c(table_name_var);
	LOOP
		FETCH c into item;
		EXIT WHEN c%NOTFOUND;
		dbms_output.put_line('Items ['||item.table_name||']');
        END LOOP;
        CLOSE c;
END;
/
	
	
