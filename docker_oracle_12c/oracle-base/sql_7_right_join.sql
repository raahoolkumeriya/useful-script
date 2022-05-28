/*
|	Program: RIGHT JOIN 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---- RIGHT [OUTER] JOIN ------;
prompt --- Opposite of LEFT JOIN --;
prompt --- Return all valid from the tabels on the right side of JOIN Keyword, along with the values from the table on left side or NULL if a matching rows doesnt exists;
prompt --- ASCI RIGHT JOIN -----;

SELECT 	d.department_name, e.employee_name
FROM 	employees e
	RIGHT OUTER JOIN departments d 
		ON e.department_id = d.department_id
WHERE 	d.department_id >= 30
ORDER BY 1,2;


prompt ---- NON ASCI equivalents ------;

SELECT d.department_name,
       e.employee_name      
FROM   departments d, employees e
WHERE  d.department_id = e.department_id (+)
AND    d.department_id >= 30
ORDER BY d.department_name, e.employee_name;


prompt -------------------------------------------------;
prompt Remember, the non-ANSI outer join syntax is not dependent on table order, so there is no real concept of right or left outer joins, just outer joins.;
prompt -------------------------------------------------;

