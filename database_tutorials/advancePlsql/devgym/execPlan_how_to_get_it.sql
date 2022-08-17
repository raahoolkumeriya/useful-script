/*
|	Program: Execution Plan 
|	Author: Raahool Kumeriya
|	Change history:
|		08-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt There are two types of Plan available;
prompt EXPLAIN and EXECUTION;
prompt ---------------------------------------------------;


prompt ---------------------------------------------------;
prompt --  EXPLAIN Plan					--;
prompt -- 	It doesnt Run the Query, so this is just prediction what might happen when you really do.;
prompt -- 	Prediction can be wrong for a whole host of reason.;
prompt ---------------------------------------------------;
prompt --		EXECUTION Plan			--;
prompt -- So for performance tunning we need execution plan.;
prompt -- Various techniques to do in oracle database;
prompt -- 	SQL monitor;
prompt -- 	DBMS_Xplan;
prompt -- 	Tracing teh query;
prompt -- 	Various 3rd party tool;
prompt ---------------------------------------------------;
prompt -- We will focus on AUTOTRACE option;
prompt ---------------------------------------------------;




