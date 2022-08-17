/*
|	Program: BITMAP Index | World of Oracle
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    		 BITMAP Index			--;
prompt ---------------------------------------------------;
/*
SELECT * FROM employees_bk;

CREATE BITMAP INDEX bitmapidx 
	ON employees_bk(HIREDATE);

 
prompt ---------------------------------------------------;
prompt --    		 Compress Index			--;
prompt ---------------------------------------------------;

CREATE INDEX cmpridx
	ON employees_bk(DEPARTMENT_ID)
	COMPRESS;

prompt ---------------------------------------------------;
prompt --    		 Verify Index			--;
prompt ---------------------------------------------------;
*/
SELECT index_name,index_type,uniqueness FROM USER_INDEXES
	WHERE lower(table_name) = 'employees_bk';

