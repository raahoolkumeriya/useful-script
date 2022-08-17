/*
|	Program: function base indexed. Searched with nominaed strings 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     --;
prompt ---------------------------------------------------;

-- CREATE index AXIOMUS.bigtab_ix_fbi
 --  ON AXIOMUS.bigtab ( to_char(dte, 'YYYY-MM_DD'));

alter session set container = ORCLPDB1;


set autotrace on stat

SELECT EMPLOYEE_ID, EMPLOYEE_NAME, JOB,MANAGER_ID, HIREDATE,SALARY, COMMISSION, DEPARTMENT_ID, DTE  FROM AXIOMUS.bigtab
WHERE to_char(dte, 'YYYY-MM-DD') >= '2022-09-27';

set autotrace off
select * from dbms_xplan.display_cursor();
