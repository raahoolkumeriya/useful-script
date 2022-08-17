/*
|	Program: Nested tables 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    Grandparents program with NESTED tables    --;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE  list_of_names_t  IS TABLE OF VARCHAR2(100);
/


DECLARE
	happyfamily 	list_of_names_t := list_of_names_t();  --- constructor 
	children	list_of_names_t := list_of_names_t();
	grandchildren	list_of_names_t := list_of_names_t();
	parents 	list_of_names_t	:= list_of_names_t();
BEGIN
	-- bulk extend to initiliza the 
	happyfamily.EXTEND(7);
	happyfamily(1) := 'Natthuji';
	happyfamily(2) := 'Kusum';
	happyfamily(3) := 'Rupali';
	happyfamily(4) := 'Rutvik';
	happyfamily(5) := 'Niyati';
	happyfamily(6) := 'Pranali';
	happyfamily(7):= 'Sanvi';


	children.EXTEND();
	children(children.LAST) := 'Rupali';
	children.EXTEND();
	children(children.LAST) := 'Rahul';
	children.EXTEND();
	children(children.LAST) := 'Pranali';
	
	grandchildren.EXTEND();
	grandchildren(grandchildren.LAST) := 'Rutvik';
	grandchildren.EXTEND();
	grandchildren(grandchildren.LAST) := 'Niyati';
	grandchildren.EXTEND();
	grandchildren(grandchildren.LAST) := 'Sanvi';


	parents := ( happyfamily MULTISET EXCEPT children ) MULTISET EXCEPT grandchildren ;
	
	FOR i IN 1..parents.LAST 
	LOOP
		DBMS_OUTPUT.PUT_LINE(parents(i));
	END LOOP;
END;
/
