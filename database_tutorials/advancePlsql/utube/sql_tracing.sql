/*
|	Program: SQL Tracing 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		SQL Tracing 			--;
prompt ---------------------------------------------------;
prompt --> Explain plan is mainly for SQL statements;
prompt --> SQL Tracing will be used for SQL and PLSQL, it generate the execution plan and some CPU statistics;
prompt --> In Explain plan, actual query will not executed, but it will statistics;
prompt --> In SQL tracing , actual query get executed and then plan is given to us;
prompt --> after SQL tracing, the output file is stroed at OS level. and file is called the Trace file.;
prompt --> The trace file have .trc file which non-readabel format., we need to convert to readable format;
prompt --> WE convert the trace file into readabel format with OS level utility "TKPROF";
prompt --> Transient kernal profile (TKPROF);
prompt ---------------------------------------------------;

ALTER SESSION set sql_trace=true;

SELECT * FROM employees where department_id = 20;

SELECT * FROM employees where department_id = 30;
  
CREATE OR REPLACE PROCEDURE cls ( p_num IN NUMBER)
IS 
	l_emp_name	VARCHAR2(30);
BEGIN
	SELECT employee_name INTO l_emp_name
	FROM employees
	WHERE employee_id = p_num;
	DBMS_OUTPUT.put_line(l_emp_name);
END;
/

exec cls(7788);
/

alter session set sql_trace=false;

show parameter user_dump_dest;

