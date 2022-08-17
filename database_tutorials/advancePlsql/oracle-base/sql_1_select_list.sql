/*
|	Program: Select List 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

/* 

SET SERVEROUTPUT ON;

SET PAGESIZE 1000 LINESIZE 192;
COL EMPLOYEE_NAME FORMAT A15;
prompt ------ Wildcard * ----------------

SELECT 	*
FROM 	employees
ORDER BY 1;


prompt ---- joined tables data with * --------

SELECT 	e.*, d.*
FROM 	employees e
	JOIN departments d 
	ON e.department_id = d.department_id
ORDER BY e.employee_id;

prompt --- Common alias ---------

SELECT 	employee_id AS ID#, employee_name AS "Name"
FROM employees
ORDER BY 1;

prompt ------------ table alias ----------;
SELECT 	e.employee_id, e.employee_name, d.department_id, d.department_name
FROM employees e
	JOIN departments d ON e.department_id = d.department_id
ORDER BY e.employee_id;

*/

prompt ---- Function ---------;

SELECT 	UPPER('lower text ') as TEXT 
FROM DUAL;

prompt -- EXPRESSION -----;
SELECT 1 + 2 AS ADDITION 
FROM DUAL;

prompt ----- SCAlers subqueries -------;
SELECT d.department_id , d.department_name, 
	( SELECT COUNT(*) FROM employees e WHERE e.department_id = d.department_id ) AS emp_count
FROM departments d
ORDER BY 1;

prompt ------  join --------;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS emp_count
FROM   departments d
       LEFT OUTER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
