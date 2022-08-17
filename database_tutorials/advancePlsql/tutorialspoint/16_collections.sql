/*
|	Program: Collections
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt -----------------------------------------------------------
prompt Collections: is an Ordered group of elements having the same data type
prompt ------------> Each element is indentified by unique subscript that represnts its position in the collection
prompt -----------------------------------------------------------
prompt --> Index-by tables or Associate Array
prompt --> Nested tables
prompt --> Variable-size array or VARRAY
prompt -----------------------------------------------------------

prompt -----------------------------------------------------------
prompt Both type of PLSQL table ie., index-by tables and nested tables have the same struture
prompt their rows are accessed using the Subscript notation.
prompt Nested table can be stored in database column and index-by tables cannot
prompt -----------------------------------------------------------


prompt -----------------------------------------------------------
prompt --> Index-by tables or Associate Array
prompt --------> is a set of KEY-VALUE pairs. Each key i sunique and is used to locate the corresponding value
prompt --------> can be string or an integer.
prompt -----------------------------------------------------------

DECLARE
	TYPE salary IS TABLE OF NUMBER 
		INDEX BY VARCHAR2(20);
	salary_list SALARY;
	name VARCHAR2(20);
BEGIN
	-- adding elements to the table
	salary_list('Rahul') := 3608500;
	salary_list('Ganesh') := 500000;
	salary_list('Chaitu') := 700000;
	salary_list('Satya') := 900000;

	-- prinitng the table
	name := salary_list.FIRST;
	WHILE name IS NOT NULL LOOP
		DBMS_OUTPUT.put_line('Salary of '||name||' is '||TO_CHAR(salary_list(name)));
		name := salary_list.NEXT(name);
	END LOOP;
END;
/

