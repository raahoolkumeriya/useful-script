/*
|	Program: Searched with nominaed strings 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     --;
prompt ---------------------------------------------------;

set autotrace on stat

SELECT EMPLOYEE_ID, EMPLOYEE_NAME, JOB,MANAGER_ID, HIREDATE,SALARY, COMMISSION, DEPARTMENT_ID, DTE  FROM AXIOMUS.bigtab
WHERE to_char(dte, 'YYYY-MM-DD') >= '2022-09-27';


