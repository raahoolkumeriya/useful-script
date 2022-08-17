/*
|	Program: SQL in PLSQL 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	l_table_exists	NUMBER;
	qry 		VARCHAR2(3000);
BEGIN
	qry := 'SELECT COUNT(*) FROM TABS WHERE table_name = ''SQL_TEST''';
	EXECUTE IMMEDIATE qry INTO l_table_exists;
	IF l_table_exists = 0 THEN
		EXECUTE IMMEDIATE 'CREATE TABLE sql_test (id NUMBER(10),description VARCHAR2(10))';
	END IF;
	DBMS_OUTPUT.PUT_LINE(l_table_exists);
END;
/

/* 
INSERT INTO sql_test (id, description) VALUES (1, 'One');
INSERT INTO sql_test (id, description) VALUES (2, 'Two');
INSERT INTO sql_test (id, description) VALUES (3, 'Three');
COMMIT;
*/

prompt ---------------------------------------;
prompt Retrive data from sql--> implicit Cursor;
prompt ---------------------------------------;

DECLARE
	l_description sql_test.description%TYPE;
BEGIN
	SELECT description 
	INTO l_description
	FROM sql_test
	WHERE id=1;
	DBMS_OUTPUT.PUT_LINE('l_description = '||l_description);
END;
/

prompt ---------------------------------------;
prompt Retrive data from sql--> Explicit Cursor;
prompt ---------------------------------------;

DECLARE 
	l_description sql_test.description%TYPE;
	
	CURSOR cur_query (p_id IN NUMBER) IS
		SELECT description FROM
		sql_test where id = p_id;
BEGIN
	OPEN cur_query ( p_id => 1);
	FETCH cur_query INTO l_description;
	CLOSE cur_query;
	DBMS_OUTPUT.PUT_LINE('l_description from Cursor = '||l_description);
END;
/


prompt ---------------------------------------;
prompt Multiple queries from table; 
prompt ---------------------------------------;

BEGIN
	FOR i IN (SELECT id,description FROM sql_test) 
	LOOP
		DBMS_OUTPUT.PUT_LINE('Id : '||i.id ||' --> '||i.description);
	END LOOP;
END;
/

prompt ---------------------------------------;
prompt Multiple queries from table with Cursor; 
prompt ---------------------------------------;

DECLARE
	l_description 	sql_test.description%TYPE;
	CURSOR cur_data IS
		SELECT description 
		FROM sql_test;
BEGIN
	OPEN cur_data;
	LOOP
	FETCH cur_data INTO l_description;
		EXIT WHEN cur_data%NOTFOUND;	
		DBMS_OUTPUT.PUT_LINE(l_description);	
	END LOOP;
	CLOSE cur_data;
END;
/

