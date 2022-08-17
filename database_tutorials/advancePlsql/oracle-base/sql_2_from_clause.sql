/*
|	Program: FROM Clause 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ----------- Inline views ------------;
prompt Subquires in FROM clause also known as inline views;
prompt ------------------------------------------------------;
SELECT ed.employee_name, ed.department_name
FROM	( SELECT e.employee_name, d.department_name
	FROM employees e, departments d
	WHERE d.department_id = e.department_id) ed
ORDER BY 1;

prompt -------- WITH clause --------------;
prompt Alternaticve to inline views is to move subquery out with WITH clause.;
prompt ------------------------------------------------------;

WITH emp_dept_join AS (
	SELECT e.employee_name, d.department_name
	FROM 	employees e , departments d
	WHERE d.department_id = e.department_id
)
SELECT ed.employee_name, ed.department_name
FROM emp_dept_join ed 
ORDER BY 1;

prompt ---------- VIEWS -----------------;
prompt Another alternative to create a conventional views based on the subquery;
prompt Views hides complexity of the query ;
prompt ------------------------------------------------------;

CREATE OR REPLACE VIEW emp_dept_join AS
	SELECT e.employee_name, d.department_name
	FROM employees e, departments d
	WHERE d.department_id = e.department_id;

SELECT ed.employee_name, ed.department_name
FROM emp_dept_join ed 
ORDER BY 1;


prompt ---- Pipelined Table Functions -----------------;

CREATE OR REPLACE TYPE t_employee_name_tab AS TABLE OF VARCHAR2(10);
/

CREATE OR REPLACE FUNCTION get_employee_names
	RETURN t_employee_name_tab PIPELINED
AS
	BEGIN
		FOR cur_rec IN ( SELECT employee_name FROM employees ) LOOP
			PIPE ROW ( cur_rec.employee_name);
		END LOOP;
	RETURN;
END;
/

SELECT e.column_value AS employee_name
FROM TABLE(get_employee_names) e
ORDER BY e.column_value;

