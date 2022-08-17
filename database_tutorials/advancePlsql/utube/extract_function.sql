/*
|	Program: EXTRACT Function 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		EXTRACT Function		--;
prompt ---------------------------------------------------;
prompt  EXTRACT([year|month|day] from <column_name>);


SELECT HIREDATE, EXTRACT(year from HIREDATE) FROM employees;

SELECT HIREDATE, EXTRACT(month from HIREDATE) FROM employees;

SELECT HIREDATE, EXTRACT(day from HIREDATE) FROM employees;

