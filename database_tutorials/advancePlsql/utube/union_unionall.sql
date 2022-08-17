/*
|	Program: Union Vs UNionAll 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Union Vs UNionAll		--;
prompt ---------------------------------------------------;
prompt -- When we are using multiple tables and we want to club all tables we use union and unionall;

prompt ---------------------------------------------------;
prompt --     		Union 				--;
prompt ---------------------------------------------------;
SELECT * FROM employees
	UNION
SELECT * FROM employees_bk;

prompt ---------------------------------------------------;
prompt --     		UNionAll			--;
prompt ---------------------------------------------------;

SELECT * FROM employees
        UNION ALL
SELECT * FROM employees_bk;


prompt ---------------------------------------------------;
prompt --     UNionAll is FASTER			--;
prompt ---------------------------------------------------;
prompt -- Union will sort and remove duplicates and display the vales;
prompt -- Unionall will display all teh data from all the tables;
prompt ---------------------------------------------------;
