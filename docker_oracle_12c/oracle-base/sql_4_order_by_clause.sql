/*
|	Program: ORDER BY  
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

SELECT e.salary, e.commission, e.employee_name
FROM employees e
WHERE department_id = 30
ORDER BY e.salary, e.commission;

prompt --- order by with expression --------;
SELECT e.salary, e.commission, e.employee_name
FROM employees e
WHERE department_id = 30
ORDER BY e.salary + NVL(e.commission,0);

prompt --- handling NULLs ---------------;
SELECT e.commission , e.employee_name
FROM	employees e
WHERE department_id = 30
ORDER BY e.commission ASC;

prompt ----- NULLS FIRST ---------;
SELECT e.commission , e.employee_name
FROM	employees e
WHERE department_id = 30
ORDER BY e.commission ASC NULLS FIRST;

prompt ---- NULLS LAST ---------;
SELECT e.commission , e.employee_name
FROM	employees e
WHERE department_id = 30
ORDER BY e.salary ASC NULLS FIRST, e.commission DESC NULLS LAST;

