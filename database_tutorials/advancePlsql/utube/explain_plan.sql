/*
|	Program: EXPLAIN PLAN 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		EXPLAIN PLAN			--;
prompt ---------------------------------------------------;

SELECT * FROM employees;

prompt ---------------------------------------------------;
prompt --  EXPLAIN PLAN	for select query		--;
prompt ---------------------------------------------------;
EXPLAIN PLAN FOR 
	SELECT * FROM employees WHERE department_id = 20;


prompt ---------------------------------------------------;
prompt --  Display plan details with pkg function	--;
prompt ---------------------------------------------------;

SELECT * FROM TABLE(dbms_xplan.display());


prompt ---------------------------------------------------;
prompt --  Create index 				--;
prompt ---------------------------------------------------;

CREATE INDEX idex on employees(department_id);


EXPLAIN PLAN FOR 
	SELECT * FROM employees WHERE department_id = 20;

SELECT * FROM TABLE(dbms_xplan.display());
