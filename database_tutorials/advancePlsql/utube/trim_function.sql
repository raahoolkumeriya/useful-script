/*
|	Program: TRIM Function 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		TRIM Function			--;
prompt ---------------------------------------------------;
prompt trim([leading:trailing:both] trimming_char from <string>);

SELECT '  technical ' from dual;

SELECT TRIM('  technical ') from dual;

SELECT TRIM(leading '1' from 1234) FROM DUAL;

SELECT TRIM(trailing '4' from 1234) FROM DUAL;

SELECT TRIM(both '1' from 12341) from dual;

SELECT employee_name from employees
WHERE TRIM(employee_name) LIKE '% %';

