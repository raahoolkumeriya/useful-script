/*
|	Program: PL/SQL Tips and Techniques 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';
/


prompt ---------------------------------------------------;
prompt --     PL/SQL Tips and Techniques		--;
prompt ---------------------------------------------------;
prompt o Use the compile-time warning features of PLSQL;
prompt o Don't repeat anything -- Aim for a single point of definition for everthing in your application.;
prompt o Keep your executabel section tiny;
prompt o Key performance optimization tips;
prompt  ---> Avoid row-by-row processing of non-query DML statements: Lowest hanging fruit for major performance imporovement.;
prompt  ---> Leverage teh function result cache.;
prompt ---------------------------------------------------;
 


