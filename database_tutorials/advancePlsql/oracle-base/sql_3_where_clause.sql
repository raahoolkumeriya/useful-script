/*
|	Program: WHERE Clause 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ------- ASCI join synatx, where clasue only contains filter condition --;

SELECT e.employee_name, e.salary, d.department_id, d.department_name
FROM employees e
	JOIN departments d 
	ON e.department_id = d.department_id
WHERE 	d.department_id = 20 
AND 	e.salary >= 2000
ORDER BY 1;

prompt ------- IN Condition can be evaluated against the retuned by a subquery ---;

SELECT e.employee_name, e.employee_id, e.department_id
FROM employees e
WHERE e.department_id IN ( SELECT d.department_id 
			  FROM departments d 
			  WHERE d.department_id < 30 )
ORDER BY 3,2;

prompt ----- EXISTS and NOT EXISTS Conditions -------;
prompt --- EXISTS condition evaluates to TRUE if the subquery returns one or more rows--;

SELECT d.department_id , d.department_name
FROM departments d
WHERE EXISTS ( SELECT 1
		FROM employees e
		WHERE d.department_id = e.department_id)
ORDER BY d.department_id;


