/*
|	Program: Check for execution plan 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    	Check for execution plan		--;
prompt ---------------------------------------------------;

alter session set container = ORCLPDB1;
set autotrace on

SELECT EMPLOYEE_ID, EMPLOYEE_NAME, JOB,MANAGER_ID, HIREDATE,SALARY, COMMISSION, DEPARTMENT_ID, DTE  FROM AXIOMUS.bigtab
WHERE dte >= to_Date('2022-09-27','YYYY-MM-DD');

set autotrace off

SELECT * from dbms_xplan.display_cursor();


