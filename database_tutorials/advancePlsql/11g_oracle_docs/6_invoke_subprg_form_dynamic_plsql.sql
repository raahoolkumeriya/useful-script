/*
|	Program: Invoking Subprogram from Dynamic PL/SQL Block 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt -- Invoking Subprogram from Dynamic PL/SQL Block --;
prompt ---------------------------------------------------;

select * from departments;

CREATE OR REPLACE PROCEDURE create_dept (
	deptid	IN OUT NUMBER,
	dname 	IN 	VARCHAR2,
	loc	IN	VARCHAR2
) AS
BEGIN
	INSERT INTO departments (
		DEPARTMENT_ID,DEPARTMENT_NAME,LOCATION ) 
	VALUES (deptid,dname,loc);
END;
/


DECLARE
	plsql_block	VARCHAR2(500);
	new_deptid	departments.DEPARTMENT_ID%TYPE := 60;
	new_depname	departments.DEPARTMENT_NAME%TYPE := 'HR';
	new_location	departments.LOCATION%TYPE := 'Pune';
BEGIN
	plsql_block := 'BEGIN create_dept(:a, :b, :c);END;';
	
	EXECUTE IMMEDIATE plsql_block 
		USING IN OUT new_deptid, new_depname, new_location;
END;
/


select * from departments;
