/*
|	Program: CROSS JOIN 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ------------------------------;
prompt -- A CROSS JOIN is the deliberate creation of a Cartesian product. There are no join columns specified, so every possible combination of rows between the two tables is produced.;
prompt ------------------------------;

prompt ---- ASCI CROSS JOIN ---------;

SELECT e.employee_name, d.department_name
FROM 	employees e
	CROSS JOIN departments d
ORDER BY 1,2;

prompt ---- NON-ASCI quivlarnt of CROSS JOIN ----;

SELECT e.employee_name, d.department_name
FROM 	employees e, departments d
ORDER BY 1,2;


