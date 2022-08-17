/*
|	Program: Query the rows that have 'A' in any one of the columns without using OR keywords 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --          With OR keywords                     --;
prompt ---------------------------------------------------;

SELECT * 
FROM tab1
WHERE 	COL1 = 'A'
OR 	COL2 = 'A'
OR 	COL3 = 'A'
OR 	COL4 = 'A'
OR 	COL5 = 'A';


prompt ---------------------------------------------------;
prompt --       Without OR keywords                     --;
prompt ---------------------------------------------------;
REM this way we are fetch the 5 time form table

SELECT * FROM tab1 WHERE COL1 = 'A' UNION ALL
SELECT * FROM tab1 WHERE COL2 = 'A' UNION ALL
SELECT * FROM tab1 WHERE COL3 = 'A' UNION ALL
SELECT * FROM tab1 WHERE COL4 = 'A' UNION ALL
SELECT * FROM tab1 WHERE COL5 = 'A';


prompt ---------------------------------------------------;
prompt --  BEST way &   Easiest way                     --;
prompt ---------------------------------------------------;
REM fetch only once form table

SELECT * 
FROM tab1
WHERE 'A' IN (COl1,COL2,COL3,COL4,COl5);

 
prompt ---------------------------------------------------;
prompt --        Concatnate way                         --;
prompt ---------------------------------------------------;

SELECT * 
FROM tab1
WHERE COL1||COL2||COL3||COL4||COL5 like '%A%';
 

prompt ---------------------------------------------------;
prompt --        Concatnate way                         --;
prompt ---------------------------------------------------;


SELECT * 
FROM tab1
WHERE INSTR(COL1||COL2||COL3||COL4||COL5, 'A') > 0 ;
