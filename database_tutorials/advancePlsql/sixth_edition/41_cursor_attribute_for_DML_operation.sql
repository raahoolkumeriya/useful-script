/*
||	Program: Cursor Attributes for DML Operations 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- Cursor Attributes for DML Operations    	--;
prompt ---------------------------------------------------;

select * from librarybooks;
-- BOOK_ID  TITLE AUTHOR_LAST_NAME  AUTHOR_FIRST_NAME  RATING

CREATE OR REPLACE PROCEDURE change_author_name (
	old_name_in	IN 	librarybooks.author_last_name%TYPE,
	new_name_in	IN	librarybooks.author_last_name%TYPE,
	changes_made_out OUT 	BOOLEAN)
	AUTHID DEFINER
IS 
BEGIN
	UPDATE librarybooks
		SET author_last_name = new_name_in
	WHERE author_last_name = old_name_in;

	changes_made_out := SQL%FOUND;
END;
/
SHO ERR;

prompt ----- Unit testing for procedure --->;
DECLARE
	changes_made_out BOOLEAN;
BEGIN
	change_author_name('Scammer','Hammer',changes_made_out);
END;
/
SHO ERR;

SELECT * FROM librarybooks;

prompt -----------------------------------------------;
prompt -- RETURNING Information from DML Statements --;
prompt -----------------------------------------------;
prompt -- RETURNING clause to an DML retrieve that information direclty into variables;
prompt -- With RETURNING clasue we can reduce network Round-trips;
prompt -----------------------------------------------;

DECLARE 
	myname	employees.employee_name%TYPE;
	mysal 	employees.salary%TYPE;
BEGIN
	FOR rec IN ( SELECT * FROM employees)
	LOOP
		UPDATE employees
			SET salary = salary * 1.5
		WHERE employee_id = rec.employee_id
		RETURNING salary, employee_name INTO mysal, myname;
		
		DBMS_OUTPUT.put_line('New salary for '||myname ||' = '||mysal);
	END LOOP;
END;
/



prompt -----------------------------------------------;
prompt -- Update to perfom on more than one row. retun information not just into a single variable,;
prompt -- but also into a collection using BULK COLLECT. ;
prompt -----------------------------------------------;

SELECT employee_name,salary FROM employees;

DECLARE
	TYPE name_varray IS VARRAY(20) OF employees.employee_name%TYPE;
	names name_varray := name_varray();
	TYPE number_varray IS VARRAY(20) OF employees.salary%TYPE;
	new_salaries number_varray := number_varray();
	new_salaries_return number_varray := number_varray();
BEGIN
	FOR indx IN (SELECT employee_name, salary FROM employees )
	LOOP
		names.EXTEND;
		names(names.LAST) := indx.employee_name;
		new_salaries.EXTEND;
		new_salaries(new_salaries.LAST) := indx.salary;
	END LOOP;

	FORALL indx IN names.FIRST .. names.LAST
		UPDATE employees_bk
			SET salary = new_salaries(indx)
		WHERE employee_name = names(indx)
		RETURNING salary BULK COLLECT INTO new_salaries_return;
	
	FOR indx IN new_salaries_return.FIRST .. new_salaries_return.LAST
	LOOP
		DBMS_OUTPUT.put_line(new_salaries_return(indx));
	END LOOP;
END;
/

	
			 
END;
/

