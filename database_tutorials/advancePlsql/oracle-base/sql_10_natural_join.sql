/*
|	Program: NATURAL JOIN 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

SELECT e.employee_name, d.department_name
FROM	employees e 
	NATURAL JOIN departments d
ORDER BY 1,2;

prompt -----------------------------------------------;
prompt Using a NATURAL JOIN is a bad idea. If someone adds a new column to one of the tables that happens to have the same name as a column in the other table, they may break any existing natural joins. It is effectively a bug waiting to happen.;
prompt -----------------------------------------------;
prompt You can't apply any aliased filters to columns used in natural joins,;
prompt -----------------------------------------------;
prompt ORA-25155: column used in NATURAL join cannot have qualifier;
prompt -----------------------------------------------;


SELECT e.employee_name,
       d.department_name
FROM   employees e
       NATURAL JOIN departments d
WHERE  department_id = 20
ORDER BY e.employee_name;


prompt ------ USING ----------;

SELECT e.employee_name,
       d.department_name
FROM   employees e
       JOIN departments d USING (department_id)
ORDER BY e.employee_name;



