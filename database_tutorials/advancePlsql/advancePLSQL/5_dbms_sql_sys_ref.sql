/*
|	Program: Implicit statement results in Oracle Database 12c 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt -- Implicit statement results in Oracle Database 12c  --;
prompt ---------------------------------------------------;
COL GRAPH FORMAT A40;

/*Create procedure to implicitly return the result set*/
CREATE OR REPLACE PROCEDURE p_sal_graph_12c (p_dept IN NUMBER)
AS
	/*Declare a SYS_REFCURSOR variable*/
	cur_sal SYS_REFCURSOR;
BEGIN
	/*Open the cursor for department*/
	OPEN cur_sal FOR
	SELECT employee_id, job, LPAD('*',salary/100,'.') graph
	FROM employees
	WHERE department_id = P_DEPT
	ORDER BY job;

	/*Use DBMS_SQL.RETURN_RESULT to return the cursor*/
	DBMS_SQL.RETURN_RESULT(cur_sal);
END; 
/

show errors;

/*Execute the procedure for department id 30*/
EXEC p_sal_graph_12c (30);
