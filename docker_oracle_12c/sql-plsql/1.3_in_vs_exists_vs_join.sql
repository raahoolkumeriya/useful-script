/*
|	Program: IN vs EXISTS vs JOIN 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;
SET TIMING ON;

-- sattements with an IN Clause

SELECT employee_id, EMPLOYEE_NAME, hiredate
FROM employees
WHERE department_id IN (
	SELECT department_id FROM departments);

-- statement with EXISTS clause
SELECT employee_id, employee_name, hiredate
FROM employees e
WHERE EXISTS ( SELECT d.department_id 
		FROM departments d
		WHERE e.department_id = d.department_id);

-- Statements with A JOIN

SELECT e.employee_id, e.employee_name, e.hiredate
FROM 	employees e, departments d
WHERE	e.department_id = d.department_id;
