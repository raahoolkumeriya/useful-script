/*
|	Program: Delete Profiler data 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -----------------------------------------------------------;
prompt Delete table in sequence as it contian foregin keys;
prompt -----------------------------------------------------------;

truncate table PLSQL_PROFILER_DATA;
delete from plsql_profiler_units;
delete from plsql_profiler_runs;



