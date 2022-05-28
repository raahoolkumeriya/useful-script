/*
|	Program: Nested tables
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt ---------------------------------------------
prompt Nested tables
prompt -----> Is like a One Dimensional array with an arbitary number of elements 
prompt -- Differ from ARRAY
prompt -----> An array has a declared number of elements, but nested tabels does not. The size of nested table can increase dynamically
prompt -----> An array is always dense ie., it always has consecutive subscripts. A nested array is dense intitally, but it can become sparse when elements are deleted from it.
prompt ---------------------------------------------


DECLARE
	TYPE t_nes_names IS TABLE OF VARCHAR2(10);
	TYPE t_nes_grades IS TABLE OF INTEGER;
	names t_nes_names;
	grades t_nes_grades;
	total INTEGER;
BEGIN
	names := t_nes_names('Rahul','Vishal','Aniket','Sandy','pintu');
	grades := t_nes_grades(78,89,79,98,89);
	total := names.COUNT;
	DBMS_OUTPUT.put_line('Total Students :'|| total);
	FOR i IN 1..total
	LOOP
		DBMS_OUTPUT.put_line('Student '
					||names(i) 
					||' Scores '
					||grades(i));
	END LOOP;
END;
/



DECLARE
	CURSOR cur_tp_customer IS
		SELECT * FROM tp_customers;
	TYPE t_nes_cust IS TABLE OF tp_customers.name%TYPE;
	cust_table t_nes_cust := t_nes_cust();
	counter INTEGER := 0;
BEGIN
	FOR cur in cur_tp_customer LOOP
		counter := counter + 1;
		cust_table.EXTEND;
		cust_table(counter) := cur.name;
		DBMS_OUTPUT.put_line('Customer('||counter||'): '||cust_table(counter));
	END LOOP;
END;
/
