/*
|	Program: Arrays 
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt PLSQL provides a data structure called the VARRAY, which can store a fixed-sized sequenctial collection of elements of the smae type.
prompt A VARRAY is used to store an ordered collection of data. As a Collection of variables of the same type.
prompt All VARRYs consist of contiguous memeory locations.


prompt Creating VARRY type
prompt --- Schema level

-- CREATE OR REPLACE TYPE namearray IS VARRAY(5) OF VARCHAR2(10);

prompt PLSQL Block level

DECLARE
	TYPE namesarray IS VARRAY(5) OF VARCHAR2(10);
	TYPE grades IS VARRAY(5) OF INTEGER;
	names NAMESARRAY;
	marks GRADES;
	total INTEGER;
BEGIN
	names := NAMESARRAY('Kavita', 'Pritam', 'Ayan', 'Pintu', 'Anu');
	marks := GRADES(98,97,95,96,78);
	total := names.COUNT;
	DBMS_OUTPUT.put_line('Total '
				|| total 
				|| ' Students.');
	FOR i IN 1..total
	LOOP
		DBMS_OUTPUT.put_line('Student : '
				|| names(i)
				|| ' Marks : '
				|| marks(i));
	END LOOP;
END;
/
