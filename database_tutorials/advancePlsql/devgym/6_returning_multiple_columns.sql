/*
|	Program: returning multiple columns 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    returning multiple columns                 --;
prompt ---------------------------------------------------;

CREATE TABLE animals (
	name	VARCHAR2(10),
	species	VARCHAR2(20),
	date_of_birth DATE
)
/

/*

INSERT INTO animals (name, species, date_of_birth )
SELECT COLUMN_VALUE1, COLUMN_VALUE2, COLUMN_VALUE3
	FROM TABLE ( a_function (param1, param2))
/
*/


prompt ----------------------------------------------------------;
prompt CREATE OR REPLACE TYPE animals_nt IS TABLE OF animals%ROWTYPE;
prompt --> Schema-level type has illegal reference ;
prompt --> %ROWTYPE is a PLSQL construct and this is executing in the SQL environment, so it doesn't know about ROWTYPE;
prompt ----------------------------------------------------------;
prompt ---> What we can do instead creats a OBJECT that mimic the Table structure;
prompt ----------------------------------------------------------;

CREATE OR REPLACE TYPE animal_ot IS OBJECT 
(
	name VARCHAR2(10),
	species VARCHAR2(20),
	date_of_birth DATE
);
/

CREATE OR REPLACE TYPE animal_nt IS TABLE OF animal_ot;
/
