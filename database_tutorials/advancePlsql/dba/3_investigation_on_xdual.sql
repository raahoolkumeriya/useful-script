/*
||	Program: http://www.dba-oracle.com/art_dbazine_ault_advanced_pl_sql_code.htm 
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
prompt --     	Performance Enhancements 		--;
prompt ---------------------------------------------------;

set autotrace on stat

prompt ---------------------------------------------------;
prompt --  EXPLAIN PLAN for xdual table	                --;
prompt ---------------------------------------------------;
EXPLAIN PLAN FOR
        SELECT 1 FROM XDUAL;


prompt ---------------------------------------------------;
prompt --  Display plan details with pkg function       --;
prompt ---------------------------------------------------;

SELECT * FROM TABLE(dbms_xplan.display());


set autotrace off;


