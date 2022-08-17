/*
||	Program: Collections and the Data Dictionary 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     Collections and the Data Dictionary	--;
prompt ---------------------------------------------------;
prompt ------------------- ALL_TYPES ---------------------;

SELECT type_name FROM all_types
WHERE owner = USER
AND typecode ='COLLECTION';

prompt ------------------ ALL_SOURCE --------------------;
SELECT text
FROM all_source
WHERE owner = USER AND name like  '%T' AND type = 'TYPE'
ORDER BY line;


