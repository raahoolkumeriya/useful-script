/*
|	Program: SUBSTR function  
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		SUBSTR function			--;
prompt ---------------------------------------------------;
prompt -- Help to extract goven numebr of charater from given string.;


SELECT employee_name, SUBSTR(employee_name,1,3) FROM employees;

SELECT employee_name, SUBSTR(employee_name,3,3) FROM employees;

SELECT employee_name, SUBSTR(employee_name,-3,3) FROM employees;


