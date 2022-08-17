/*
|	Program: INSTR function  
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		INSTR Function 			--;
prompt -- use to return the position of given charater in the given string;
prompt -- 0 --> If charater matches;
prompt -- 1 --> if one or more matches;
prompt -- SUBSTR will return the match string and INSTR will return position of charater;
prompt ---------------------------------------------------;

SELECT * 
FROM employees_bk
WHERE INSTR(employee_name,'A',1,1) > 0;

SELECT * 
FROM employees_bk
WHERE INSTR(employee_name,'A',1,1) = 0;

SELECT * 
FROM employees_bk
WHERE INSTR(employee_name,'A',1,2) > 0;

