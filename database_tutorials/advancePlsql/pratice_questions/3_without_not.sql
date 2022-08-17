/*
|	Program: data from TAB2 that are not exists in TAb3 without using NOT keyword 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    Straight forward solution                  --;
prompt ---------------------------------------------------;

SELECT * from tab2 where COL2 NOT in ( SELECT * from  tab3);


prompt ---------------------------------------------------;
prompt --    		with EXISTS keyword             --;
prompt ---------------------------------------------------;
SELECT * FROM TAB2 where NOT EXISTS ( SELECT 1 FROM TAB3 WHERE TAB3.COL3 = TAB2.COL2);

prompt ---------------------------------------------------;
prompt --          MINUS Operator                       --;
prompt ---------------------------------------------------;

SELECT *
FROM TAB2
	MINUS
SELECT *
FROM TAB3;

prompt ---------------------------------------------------;
prompt --    Correlated Query                           --;
prompt ---------------------------------------------------;
SELECT * 
FROM TAB2
WHERE 1 > ( SELECT COUNT(*) FROM TAB3 WHERE TAB2.COL2 = TAB3.COl3);

prompt ---------------------------------------------------;
prompt --    	LEFT Outer join                         --;
prompt ---------------------------------------------------;
SELECT * 
FROM TAB2 LEFT JOIN
TAB3 ON TAB2.COL2 = TAB3.COL3
WHERE TAB3.COL3 is NULL;

prompt ---------------------------------------------------;
prompt --    	FULL Outer join                         --;
prompt ---------------------------------------------------;
SELECT * 
FROM TAB2 FULL JOIN
TAB3 ON TAB2.COL2 = TAB3.COL3
WHERE TAB3.COL3 is NULL;


prompt ---------------------------------------------------;
prompt --    	Correlated query                        --;
prompt ---------------------------------------------------;

SELECT COl2 
FROM TAB2
WHERE ( SELECT count(1) FROM TAB3
	WHERE tab3.COl3 = tab2.col2 ) = 0;

