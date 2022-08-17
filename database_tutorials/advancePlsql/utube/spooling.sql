/*
|	Program: Spooling  
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    Spooling : process of tansfering data from sqlplus to flat file 	--;
prompt ---------------------------------------------------;

spool '/u01/advancePlsql/utube/text.txt';

SELECT * from employees;

spool off;


spool '/u01/advancePlsql/utube/text.txt' append;

SELECT * from departments;

spool off;
