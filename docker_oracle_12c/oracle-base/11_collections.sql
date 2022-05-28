/*
|	Program: Collections 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON SIZE 1000000;

prompt -----Index-By Tables (Associative array)---------;

DECLARE 
	TYPE table_type IS TABLE OF NUMBER(10)
		INDEX BY BINARY_INTEGER;
	v_tab table_type;
	v_idx NUMBER;
BEGIN
	-- Initilise the collection
	<< load_loop >>
	FOR i IN 1 .. 5 LOOP
		v_tab(i) := i;
	END LOOP load_loop;

	-- Delete the third item of collection
	v_tab.DELETE(3);
	
	-- Tranerse sparce collection
	v_idx := v_tab.FIRST;
	
	<< display_loop >>
	WHILE v_idx IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('The numebr '||v_tab(v_idx));
		v_idx := v_tab.NEXT(v_idx);
	END LOOP display_loop;
END;
/
 
prompt ------ NESTED TABLE COLLECTION -----------;

DECLARE
	TYPE table_type IS TABLE OF VARCHAR2(10);
	v_tab table_type;
	v_idx NUMBER;
BEGIN
	-- initiliaze the collection with two values
	v_tab := table_type(1,2);
	
	-- extend the colelction with extra values 
	<< load_loop >>
	FOR i IN 3..5 LOOP
		v_tab.EXTEND;
		v_tab(v_tab.LAST) := i;
	END LOOP load_loop;
	
	-- delete the third item of the collection
	v_tab.DELETE(3);

	-- traverse sparce collection
	v_idx := v_tab.FIRST;
	
	<< display_loop >>
	WHILE v_idx IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('The number '||v_tab(v_idx));
		v_idx := v_tab.NEXT(v_idx);
	END LOOP display_loop;
END;
/

prompt ------ VARRAY Collections ----------;
DECLARE
	TYPE table_type IS VARRAY(5) OF NUMBER(10);
	v_tab table_type;
	v_idx NUMBER;
BEGIN
	-- initilize the collection with two values
	v_tab := table_type(1,2);
	
	-- extend the collection with extra values
	<< load_loop >>
	FOR i IN 3 .. 5 LOOP
		v_tab.EXTEND;
		v_tab(v_tab.LAST) := i;
	END LOOP load_loop;
	
	-- can't delete from varray
	-- v_tab.DELETE(3);

	-- traverse colelction
	v_idx := v_tab.FIRST;
	<< display_loop >>
	WHILE v_idx IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('The number '||v_tab(v_idx));
                v_idx := v_tab.NEXT(v_idx);
        END LOOP display_loop;
END;
/


