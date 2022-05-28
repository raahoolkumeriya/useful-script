/*
|	Program: INNER JOINS 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt --- INNER JOIN ----------;
prompt --- Combines data from two tables where there is match on joining column in both tables ;
prompt --- ASCI INNER JOIN ---;

SELECT 	d.department_name, e.employee_name
FROM 	departments d
	JOIN employees e
		ON d.department_id = e.department_id
WHERE 	d.department_id >= 30
ORDER BY 1;

prompt ---- NON ASCI equivalent ----;
SELECT  d.department_name, e.employee_name
FROM 	departments d, employees e
WHERE 	d.department_id = e.department_id
AND 	d.department_id >= 30
ORDER BY 1;

