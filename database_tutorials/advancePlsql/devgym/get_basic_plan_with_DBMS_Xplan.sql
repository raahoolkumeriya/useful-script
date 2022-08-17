/*
||	Program: Get a Basic Plan with DBMS_XPlan 
||	Author: codelocked
||	Change history:
||		08-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- 	Get a Basic Plan with DBMS_XPlan	--;
prompt ---------------------------------------------------;

select *
from   bricks b
join   colours c
on     b.colour = c.colour;


VARIABLE LIVESQL_LAST_SQL_ID VARCHAR2(15);

BEGIN
	select sql_id INTO :LIVESQL_LAST_SQL_ID from  v$sql
                where  sql_text like 'select *%bricks b%';
END;
/


-- PRINT :LIVESQL_LAST_SQL_ID;

SELECT :LIVESQL_LAST_SQL_ID FROM DUAL; 


select * 
from   table(dbms_xplan.display_cursor(:LIVESQL_LAST_SQL_ID));


prompt ---------------------------------------------------;
prompt -- 	Reading a Four Table Join Plan		--;
prompt ---------------------------------------------------;

select c.*, pen_type, shape, toy_name
from   colours c
join   pens p
on     c.colour = p.colour
join   cuddly_toys t
on     c.colour = t.colour
join   bricks b
on     c.colour = b.colour;


select sql_id,sql_text  from  v$sql;


VARIABLE x VARCHAR2(15);
BEGIN
        select sql_id INTO :x from  v$sql
                where  sql_text like 'select *%cuddly_toys t%'
		and    sql_text NOT like '%from   bricks b%';
END;
/

PRINT :x;


select *
from   table(dbms_xplan.display_cursor(:x));

