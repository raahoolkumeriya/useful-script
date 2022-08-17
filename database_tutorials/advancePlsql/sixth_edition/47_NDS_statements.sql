/*
||	Program: NDS Statements 
||	Author: Raahool Kumeriya
||	Change history:
||		15-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		NDS Statements			--;
prompt ---------------------------------------------------;
prompt -- The EXECUTE IMMEDIATE Statement	----------;

CREATE OR REPLACE PACKAGE dynamic_sql 
	AUTHID DEFINER
IS
	-- Create index 
	PROCEDURE exec_DDL ( p_ddl_string IN VARCHAR2);
	
	-- Obtain count of rows in any tables
	FUNCTION tabcount (p_table_in IN VARCHAR2) RETURN PLS_INTEGER;

	-- udpate the value of a numeric column and return the number of rows that have updated
	FUNCTION updNVal (
		p_col 	IN VARCHAR2, p_val IN NUMBER,
		p_start_in IN DATE, p_end_in IN DATE) RETURN PLS_INTEGER;

	PROCEDURE run_9am_procedure ( p_id_in IN employees.employee_id%TYPE,
			p_hours_in IN INTEGER);
 
END dynamic_sql;
/

SHOW ERRORS;

-- package body
CREATE OR REPLACE PACKAGE BODY dynamic_sql 
IS
	PROCEDURE exec_DDL ( p_ddl_string IN VARCHAR2)
	IS
	BEGIN
		EXECUTE IMMEDIATE p_ddl_string;
	END exec_DDL;

	FUNCTION tabcount (p_table_in IN VARCHAR2) RETURN PLS_INTEGER
	IS
		l_query VARCHAR2(32767) := 'SELECT COUNT(*) FROM '||p_table_in;
		l_return PLS_INTEGER;
	BEGIN
		EXECUTE IMMEDIATE l_query INTO l_return;
		RETURN l_return;
	END;

	
	FUNCTION updNVal (
		p_col 	IN VARCHAR2, p_val IN NUMBER,
		p_start_in IN DATE, p_end_in IN DATE)
		RETURN PLS_INTEGER
	IS
	BEGIN
		EXECUTE IMMEDIATE 
			'UPDATE employees_bk SET '||p_col||' = :the_value
			WHERE HIREDATE BETWEEN :lo AND :hi'
		   USING p_val, p_start_in, p_end_in;
		RETURN SQL%ROWCOUNT;
	END updNVal;


	PROCEDURE run_9am_procedure ( p_id_in IN employees.employee_id%TYPE,
			p_hours_in IN INTEGER)
	IS 
		v_apptCount INTEGER;
		v_name	VARCHAR2(100);
	BEGIN
		EXECUTE IMMEDIATE 
			'BEGIN ' || TO_CHAR(SYSDATE, 'DAY') ||
				'_set_schedule (:id, :hour, :name, :appts); END;'
			USING IN 
				p_id_in, IN p_hours_in, OUT v_name, OUT v_apptCount;

		DBMS_OUTPUT.put_line(
			'Employee '|| v_name || ' has '||v_apptCount ||
			' appointments on '|| TO_CHAR(SYSDATE));
	
	END run_9am_procedure;

END dynamic_sql;
/

SHOW ERROR;

/*
prompt ----- UNIT TEST package ----;
BEGIN
	dynamic_sql.exec_DDL('CREATE INDEX emp_u_1 ON employees_bk (employee_name)');
END;
/

BEGIN
	IF dynamic_sql.tabcount('employees') > 100
	THEN
		DBMS_OUTPUT.put_line('We are growing fast!');
	END IF;
END;
/
*/

-- SELECT dynamic_sql.updNVal('employee_id',9999, '22-JAN-82','23-JAN-83') FROM DUAL;


BEGIN
	dynamic_sql.run_9am_procedure(7788, 20);
END;
/
