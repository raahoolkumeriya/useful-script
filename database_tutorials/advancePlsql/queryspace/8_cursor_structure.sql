prompt >>>>> Cursor Structure <<<<<


SET SERVEROUTPUT ON;

prompt > Implicit Cursor 


DECLARE
	n NUMBER;
BEGIN
	SELECT 1 INTO n FROM dual;
	dbms_output.put_line('Selected ['||SQL%ROWCOUNT||']');
END;
/

prompt >> SIngle-Row Implicit Cursor
DECLARE
	tablename	all_tables.table_name%TYPE;
BEGIN
	SELECT table_name INTO tablename FROM all_tables where ROWNUM < 2;
	dbms_output.put_line('Selected ['||tablename||']');
END;
/

prompt >> Assign column to a record datatype
DECLARE
	TYPE item_record IS RECORD
		( table_name 	all_tables.table_name%TYPE
		, owner		all_tables.owner%TYPE);
	dataset ITEM_RECORD;
BEGIN
	SELECT table_name, owner 
	INTO dataset
	FROM all_tables 
	WHERE rownum < 2;
	dbms_output.put_line('Iteration ['||dataset.table_name||']');
END;
/


prompt >> Multiple-Row Implicit cursor
prompt  ----- Implicit cursor by DML statement

BEGIN
	FOR i IN ( SELECT table_name,OWNER FROM all_tables WHERE table_name LIKE '%MAP') LOOP
		dbms_output.put_line('Items ['||i.table_name||']['|| i.owner||']');
	END LOOP;
END;
/


prompt >>>> Explicit Cursors

DECLARE 
	table_name 	all_tables.table_name%TYPE;
	owner		VARCHAR2(10);
	CURSOR c IS 
		SELECT table_name
		,	owner
		FROM all_tables;
BEGIN
	OPEN c;
	LOOP 
		FETCH c INTO table_name, owner ;
		EXIT WHEN c%NOTFOUND;
		dbms_output.put_line('Items ['||table_name||']['||owner||']');
	END LOOP;
	CLOSE c;
END;
/


prompt >>> Cursor FoR LOOP

DECLARE
	CURSOR c IS 
		SELECT table_name 
		,	owner
		FROM 	all_tables;
BEGIN
	FOR i in c LOOP
		dbms_output.put_line('Items ['||i.table_name||']  ['|| i.owner||']');
	END LOOP;
END;
/


prompt Define, Open, fetches From and Closes Cursor into a RECORD structure

DECLARE
	TYPE item_record IS RECORD
	( table_name 	VARCHAR2(30)
	, owner 	VARCHAR2(10));
	item ITEM_RECORD;
	CURSOR c IS
		SELECT table_name
		, owner
		FROM all_tables;
BEGIN
	OPEN c;
	LOOP
		FETCH c INTO item;
		EXIT WHEN c%NOTFOUND;
			dbms_output.put_line('Items ['||item.table_name||'] ['|| item.owner||']'); 
	END LOOP;
END;
/





prompt NO data FOund in Cursor
DECLARE
	TYPE item_record IS RECORD
	( table_name VARCHAR2(30)
	, owner	VARCHAR2(10));
	item ITEM_RECORD;
	CURSOR c IS 
		SELECT table_name 
		, 	owner
		FROM all_Tables
		WHERE table_name = 'NO_TABLE_EXISTS';
BEGIN
	OPEN c;
	LOOP
		FETCH c into item;
		IF c%NOTFOUND THEN
			IF c%ROWCOUNT = 0 THEN
				dbms_output.put_line('No data found');
			END IF;
			EXIT;
		ELSE
			dbms_output.put_line('Items ['||item.table_name||']['|| item.owner||']'); 
		END IF;
	END LOOP;
	CLOSE c;
END;
/

