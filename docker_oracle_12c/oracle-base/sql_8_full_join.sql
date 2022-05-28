/*
|	Program: Full join 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ----- FULL join -----;
prompt -- Combines all rows from the tables on the left and right sides of the join. If either side has missing data, it is replaced by NULLs, rather than throwing the row away.

-- INSERT INTO employees VALUES (8888,'JONES','DBA',null,to_date('02-1-1982','dd-mm-yyyy'),1300,NULL,NULL);

SELECT e.employee_name, d.department_name
FROM 	employees e
	FULL OUTER JOIN departments d
		ON e.department_id = d.department_id
ORDER BY 1,2;


prompt --------------------------------------------;
prompt There is no direct equivalent of a full outer join using the non-ANSI join syntax, but we can recreate it by combining two outer join queries using a UNION ALL;
prompt --------------------------------------------;

SELECT 	d.department_name, e.employee_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id (+)
UNION ALL
SELECT 	d.department_name, e.employee_name
FROM 	departments d, employees e
WHERE 	d.department_id = e.department_id (+)
AND 	e.employee_name IS NULL
ORDER BY 1,2;

