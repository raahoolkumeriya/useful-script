/*
|	Program: trace with SQL  
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   TRACE with SQL query		        --;
prompt ---------------------------------------------------;


select sql_id, sql_text from v$sql;

--  where  sql_text like '%some text from your query%'
--  and    sql_text not like '%not this%';


