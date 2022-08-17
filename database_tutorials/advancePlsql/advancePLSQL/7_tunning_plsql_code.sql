/*
|	Program: Build secure applications using bind variables 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --Build secure applications using bind variables --;
prompt ---------------------------------------------------;

/*
-- Select employees table with a bidn variable
SELECT employee_name, job, department_id
FROM	employees
WHERE employee_id = :EMID
/
*/

prompt ---------------------------------------------------;
prompt -- 	without BIND Variable 			--;
prompt ---------------------------------------------------;

DECLARE
	l_count NUMBER;
	l_stmt	VARCHAR2(4000);
	clock_in	NUMBER;
	clock_out 	NUMBER;

	TYPE v_obj_type IS TABLE OF VARCHAR2(100);
	l_obj_type v_obj_type := v_obj_type('TYPE','PACKAGE','PROCEDURE','TABLE','SEQUENCE','OPERATOR','SYNONYM');
BEGIN
	-- captur estart time
	clock_in := DBMS_UTILITY.get_time();

	FOR i IN l_obj_type.FIRST .. l_obj_type.LAST
	LOOP
		l_stmt := 'SELECT count(*)
				FROM all_objects
				WHERE object_type = '||''''||l_obj_type(i)||'''';
		EXECUTE IMMEDIATE l_stmt INTO l_count;
	END LOOP;
	
	-- capture the end time
	clock_out := DBMS_UTILITY.get_time();

	DBMS_OUTPUT.PUT_LINE('Execution time without bind variables : '||TO_CHAR(clock_out - clock_in ));
END;
/


prompt ---------------------------------------------------;
prompt -- 	with BIND Variable 			--;
prompt ---------------------------------------------------;

DECLARE
	l_count NUMBER;
	l_stmt	VARCHAR2(4000);
	clock_in	NUMBER;
	clock_out 	NUMBER;

	TYPE v_obj_type IS TABLE OF VARCHAR2(100);
	l_obj_type v_obj_type := v_obj_type('TYPE','PACKAGE','PROCEDURE','TABLE','SEQUENCE','OPERATOR','SYNONYM');
BEGIN
	-- captur estart time
	clock_in := DBMS_UTILITY.get_time();

	FOR i IN l_obj_type.FIRST .. l_obj_type.LAST
	LOOP
		-- bind the select statement by using bind variable
		l_stmt := 'SELECT count(*)
			FROM all_objects
			WHERE object_type = :p1';
		-- use dynamic sql to execute the SELECT statements
		EXECUTE IMMEDIATE l_stmt INTO l_count USING l_obj_type(i);
	END LOOP;

	-- capture the end time
	clock_out := DBMS_UTILITY.get_time();

	DBMS_OUTPUT.PUT_LINE('Execution time with bind variables : '||TO_CHAR(clock_out - clock_in ));
END;
/	
