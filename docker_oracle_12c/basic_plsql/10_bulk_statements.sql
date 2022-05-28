prompt -----------  Bulk statements -------------

prompt >> BULK Statements let you select, insert, update or delete large data sets from table or views
prompt >> You use BULK COLLECT statement with SELECT statement 
prompt >>     and FORALL statement to INSERT, UPDATE or DELETE large data sets

prompt ---- BULK COLLECT INTO Statements
prompt -- Parallel Collection targets

SET SERVEROUTPUT ON;

DECLARE
	TYPE title_collection IS TABLE OF VARCHAR2(60);
	TYPE subtitle_collection IS TABLE OF VARCHAR2(60);
	title TITLE_COLLECTION;
	subtitle SUBTITLE_COLLECTION;
BEGIN
	SELECT first_name
	,      last_name
	BULK COLLECT INTO title, subtitle
	FROM employees;
	-- print one element of one of the parallel collection
	FOR i IN 1..title.COUNT LOOP
		dbms_output.put_line('Name ['||title(i)||']');
	END LOOP;
END;
/
		

prompt -- Records Collection targets

DECLARE
	TYPE title_record IS RECORD
	( first_name VARCHAR2(30)
	, last_name VARCHAR2(30));
	TYPE collection IS TABLE OF TITLE_RECORD;
	employee COLLECTION;
BEGIN
	SELECT first_name, last_name
	BULK COLLECT INTO employee
	FROM employees;
	-- print one element of a structure
	FOR i IN 1..employee.COUNT LOOP
		dbms_output.put_line('Name of employee ['||employee(i).first_name||']');
	END LOOP;
END;
/

prompt --- LIMIT Constrained Collection targets
prompt >> Parallel Collection targets

DECLARE
	-- define scalar datatypes
	TYPE title_collection IS TABLE OF VARCHAR2(60);
	TYPE subtitle_collection IS TABLE OF VARCHAR2(60);
	-- define local variables
	firstname TITLE_COLLECTION;
	lastname SUBTITLE_COLLECTION;
	-- Define static cursor
	CURSOR c IS
		SELECT first_name, last_name
		FROM employees;
BEGIN
	OPEN c;
	LOOP
		FETCH c BULK COLLECT INTO firstname, lastname LIMIT 10;
		EXIT WHEN firstname.COUNT = 0;
		FOR i IN 1..firstname.COUNT LOOP
			dbms_output.put_line('First name ['||firstname(i)||']');
		END LOOP;
	END LOOP;
END;
/

prompt >> Record COllection Targets
DECLARE
	TYPE title_record IS RECORD 
	( first_name VARCHAR2(30)
	, last_name VARCHAR2(30));
	TYPE collection IS TABLE OF TITLE_RECORD;
	full_name COLLECTION;
	CURSOR c IS
		SELECT first_name, last_name
		FROM employees;
BEGIN
	OPEN c;
	LOOP
		FETCH c BULK COLLECT INTO full_name LIMIT 10;
		EXIT WHEN full_name.COUNT = 0;
		FOR i IN 1..full_name.COUNT LOOP
			dbms_output.put_line('Forename ['||full_name(i).first_name||'] Surname ['||full_name(i).last_name||']');
		END LOOP;
	END LOOP;
END;
/
	

prompt ----- FORALL
prompt >> it is design to work with Oracle Collections. it let you INSERT, UPDATE, or DELETE bulk data

CREATE TABLE ITEM_TEMP
	( item_id  NUMBER
		, item_title VARCHAR2(62)
		, item_subtitle VARCHAR2(60));


DECLARE
  	TYPE id_collection IS TABLE OF NUMBER;
  	TYPE title_collection IS TABLE OF VARCHAR2(60);
  	TYPE subtitle_collection IS TABLE OF VARCHAR2(60);
  	id       ID_COLLECTION;
  	title    TITLE_COLLECTION;
  	subtitle SUBTITLE_COLLECTION;
  	CURSOR c IS
		SELECT EMPLOYEE_ID
			,FIRST_NAME
			,LAST_NAME 
		FROM employees;
BEGIN 
	OPEN c;
	LOOP
		FETCH c BULK COLLECT INTO id, title, subtitle LIMIT 10; EXIT WHEN title.COUNT = 0;
		FORALL i IN id.FIRST..id.LAST
      			INSERT INTO item_temp VALUES (id(i),title(i),subtitle(i));
			dbms_output.put('Inserted ');
	END LOOP;
END; 
/

DROP TABLE ITEM_TEMP;

