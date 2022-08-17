/*
|	Program:  WITH Clause
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		WITH Clause			--;
prompt ---------------------------------------------------;
prompt -- Main purpose of WITH Clause is imporve performance of query;
prompt -- It is very similar to temporary tables (GTT);
prompt -- it is use like temporary tables;
prompt -- it alwasy start with WITH clause;
prompt SYNTAX:;
prompt WITH name_query AS;
prompt (;
prompt 	   sql-----query-----;
prompt );
prompt SELECT * FROM name_query;;
prompt ---------------------------------------------------;
prompt -- math operation by dividing the salary of employee with total number of employee in each dpeartment;

WITH department_name AS
( 
	SELECT department_id, count(1) as no_emp
	FROM employees
	GROUP BY department_id 
)
SELECT employee_name, salary / no_emp
FROM employees e, department_name d
WHERE e.department_id = d.department_id;

