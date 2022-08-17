/*
|	Program: Datatypes
|	Author: Raahool Kumeriya
|	Change history:
|		11-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		Declaring Variables		--;
prompt ---------------------------------------------------;

DECLARE
	/*
	|	DECLARING VARIBALES
	*/
	-- simple decalration of numeric variable
	l_total_count 	NUMBER;
	
	-- declaration of number that rounds to nearest hundredth (cent)
	l_dollar_amount NUMBER(10,2);
	
	-- A single datetime value assigned a default value of the database
	-- server system clock . Also it can never be NULL
	l_right_now	DATE NOT NULL DEFAULT SYSDATE;

	-- using the assignment process for associative array
	-- first the type of table
	TYPE list_of_emps_t IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;
	-- and now the specific list to be manipulated in this block
	employee_list list_of_emps_t;

	/*
	|	DECLARING CONSTANTS
	*/
	-- the current year number; its not going to change during my session
	l_curr_year	CONSTANT PLS_INTEGER := TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'));

	-- Using the DEFAULT Keyword
	l_name CONSTANT VARCHAR2(100) DEFAULT 'Raahool Kumeriya';

	-- Decalre a complex datatype as a constant 
	-- this isn't just for scalars
	l_rahul CONSTANT person_ot := person_ot('HUMAN','Rahul Kumeriya',175, TO_DATE('01-01-2000','MM-DD-YYYY'));
BEGIN
	null;
END;
/
