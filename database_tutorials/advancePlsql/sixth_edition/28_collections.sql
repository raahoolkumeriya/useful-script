/*
||	Program: Collections 
||	Author: Raahool Kumeriya
||	Change history:
||		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		COLLECTIONs			--;
prompt ---------------------------------------------------;
prompt o Associative Array :- Single-Dimensional, Sparse, Unbounded collecition of homogenous elements;
prompt ---------------------------------------------------;

DECLARE
	TYPE list_of_books_t IS TABLE OF books.title%TYPE
		INDEX BY PLS_INTEGER;
	happyfamily 	list_of_books_t;
	l_row		PLS_INTEGER;
BEGIN
	happyfamily(2020202020) := 'Raahool';
	happyfamily(-12354) := 'Nikki';
	happyfamily(-90900) := 'Father';
	happyfamily(88) := 'Mother';
	
	l_row := happyfamily.FIRST;

	WHILE ( l_row IS NOT NULL)
	LOOP
		DBMS_OUTPUT.put_line(happyfamily(l_row));
		l_row := happyfamily.NEXT(l_row);
	END LOOP;
END;
/
 
prompt ---------------------------------------------------;
prompt o Nested table :- Single-Dimensional, Unbounded collecition of homogenous elements;
prompt ---------------------------------------------------;

REM Section A
CREATE OR REPLACE TYPE list_of_names_t IS TABLE OF VARCHAR2(100);
/

REM Section B
DECLARE 
	happyfamily	list_of_names_t := list_of_names_t();
	children	list_of_names_t := list_of_names_t();
	parents		list_of_names_t	:= list_of_names_t();
BEGIN
	happyfamily.EXTEND(4);
	happyfamily(1) := 'Eli';
	happyfamily(2) := 'Steven';
	happyfamily(3) := 'Chris';
	happyfamily(4) := 'Veva';

	children.EXTEND;
	children(1) := 'Chris';
	children.EXTEND;
	children(2) := 'Eli';

	parents := happyfamily MULTISET EXCEPT children;
	
	FOR l_row IN parents.FIRST .. parents.LAST
	LOOP
		DBMS_OUTPUT.put_line(parents(l_row));
	END LOOP;
END;
/
		

prompt ---------------------------------------------------;
prompt o VARRAYs :- Single-Dimensional, bounded collecition of homogenous elements;
prompt ---------------------------------------------------;
REM section A
CREATE OR REPLACE TYPE first_names_t IS VARRAY(2) OF VARCHAR2(100);
/

CREATE OR REPLACE TYPE child_names_t IS VARRAY(1) OF VARCHAR2(100);
/

REM section B
CREATE TABLE family (
	surname		VARCHAR2(1000)
,	parent_names	first_names_t
,	children_names	child_names_t
);

REM Section C
DECLARE
	parents 	first_names_t := first_names_t();
	children	child_names_t := child_names_t();
BEGIN
	parents.EXTEND(2);
	parents(1)	:= 'Samuel';
	parents(2)	:= 'Charina';

	children.EXTEND;
	children(1) := 'Feather';
	
	INSERT INTO family 
			(surname, parent_names, children_names)
		VALUES  ('Assurty', parents, children);
END;
/

SELECT * FROM family;
/


