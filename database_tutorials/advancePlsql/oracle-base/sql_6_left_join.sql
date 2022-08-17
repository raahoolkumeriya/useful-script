/*
|	Program: LEFT JOIN 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---- LEFT [OUTER] JOIN ------;
prompt --- Return all valid from the tabels on the left side of JOIN Keyword, along with the values from the table on rigth side or NULL if a matching rows doesnt exists;
prompt --- ASCI LEFT JOIN -----;

SELECT 	d.department_name, e.employee_name
FROM 	departments d
	LEFT JOIN employees e
		ON d.department_id = e.department_id
WHERE 	d.department_id >= 30
ORDER BY 1,2;

prompt ---- NON ASCI equivalents ------;
SELECT  d.department_name, e.employee_name
FROM 	departments d, employees e
WHERE 	d.department_id = e.department_id (+)
AND 	d.department_id >= 30
ORDER BY 1,2;

prompt --- adding filter condition returned from an outer joined table is a common case of confusion.

SELECT 	d.department_name, e.employee_name
FROM 	departments d
	LEFT OUTER JOIN employees e 
		ON d.department_id = e.department_id AND e.salary >= 2000
WHERE 	d.department_id >= 30
ORDER BY 1,2;

prompt --- Using NON-ASCI -----

SELECT 	d.department_name, e.employee_name
FROM 	departments d, employees e
WHERE 	d.department_id = e.department_id (+)
AND	e.salary (+) >= 2000
AND 	d.department_id >= 30
ORDER BY 1,2;


