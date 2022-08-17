/*
|	Program: Cursor variables as arguments 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Cursor variables as arguments		--;
prompt ---------------------------------------------------;

COL GRAPH FORMAT A50;
-- proceudre using cursor variabel as formal parameter
CREATE OR REPLACE PROCEDURE p_sal_graph (
				p_dept NUMBER, p_emp_data OUT SYS_REFCURSOR )
IS
	-- Declare a local ref cursor variable
	TYPE cur_emp IS REF CURSOR;
	cur_sal cur_emp;
BEGIN
	-- open the local ref cursor variabel for select query
	OPEN cur_sal FOR
		SELECT employee_id, job, LPAD('*',salary/100,'.') graph 
		FROM employees
		WHERE department_id = p_dept
		ORDER BY job;

	-- asisgn the out parameter with the local cursor variable
	p_emp_data := cur_sal;
END;
/


show errors;

-- declare a host cursor variabel in sql*PLUS
VARIABLE M_EMP_SAL REFCURSOR;

EXEC  p_sal_graph(30, :M_EMP_SAL);

-- print the host cursor variable
PRINT M_EMP_SAL;

