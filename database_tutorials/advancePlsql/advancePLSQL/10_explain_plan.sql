/*
|	Program: Explain plan 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Explain plan			--;
prompt ---------------------------------------------------;


SET TIMING ON
CREATE TABLE my_objects
AS SELECT * FROM all_objects
/
SELECT count (*)
FROM my_objects
/


SELECT /*+RESULT_CACHE GATHER_PLAN_STATISTICS*/
  object_type,
  status,
  count(*)
FROM my_objects
GROUP BY object_type, status
ORDER BY object_type, status
/


SELECT *
FROM DBMS_XPLAN.DISPLAY_CURSOR()
/
