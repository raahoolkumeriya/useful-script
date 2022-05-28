/*
|	Program: LATERAL inline views 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---- LATERAL inline views -------;
prompt -- Normally, it is not possible to reference tables outside of an inline view definition;
prompt -------------------------------------------------------;
prompt A LATERAL inline view allows us to reference the table on the left of the inline view definition in the FROM clause, allowing the inline view to be correlated.; 
prompt This is also known as left correlation.;
prompt -------------------------------------------------------;

SELECT department_name, employee_name
FROM 	departments d
	CROSS JOIN LATERAL ( SELECT 	employee_name
			FROM 	employees e
			WHERE 	e.department_id = d.department_id)
ORDER BY 1,2;


