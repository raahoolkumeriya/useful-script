/*
||	Program: HR shema creation  
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
prompt --     	HR Schema creation 			--;
prompt ---------------------------------------------------;

ALTER SESSION SET container = ORCLPDB1;

@/u01/app/oracle/product/12.2.0/dbhome_1/demo/schema/human_resources/hr_main.sql
