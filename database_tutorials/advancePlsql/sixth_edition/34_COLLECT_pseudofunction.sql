/*
||	Program: The COLLECT pseudofunction 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     	The COLLECT pseudofunction		--;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE strings_nt IS TABLE OF VARCHAR2(100)
/

SHO ERR;

prompt ----> Calling COLLECT and ordering the result ---->; 
COL BY_HIRE_DATE FORMAT A100;


SELECT department_id,
	CAST(COLLECT (employee_name ORDER BY hiredate) AS strings_nt) AS by_hire_date
FROM employees
GROUP BY department_id
/

prompt ---> Remove duplicate in the aggregration process --->;
COL uniques_jobs FORMAT A100;

SELECT department_id,
		CAST ( COLLECT ( DISTINCT job) AS strings_nt) AS uniques_jobs
FROM employees
GROUP BY department_id
/


