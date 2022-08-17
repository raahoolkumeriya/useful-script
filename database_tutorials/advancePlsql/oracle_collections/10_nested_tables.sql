/*
|	Program: Nested tables 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt --------------------------;
prompt --    NESTED TABLES     --;
prompt --------------------------;
prompt A nested table is a Column type that stores 

prompt -- Difference between VARRAY and NESTED tables --;
prompt > Number of elements it is going to store. Sparsing of elements. While defineing Varray has upper bound , where as NESTED tabel can hold N number of elements;
prompt > In Varray we are not able to delete the within elements. Only able to delete end of elements. Varray will be continuous and NEStED tabel will be non-continuous.
prompt -------------------------------------------------;

prompt Define
prompt Declare
prompt Initlilze
prompt assign
prompt Access

DECLARE 
	TYPE v_nested_tab_type IS TABLE OF VARCHAR2(30);
	v_day v_nested_tab_type := v_nested_tab_type(NULL,NULL);
BEGIN
	v_day(1) := 'MON';
	v_day(2) := 'TUE';
	v_day.EXTEND(1);
	v_day(3) := 'WED';

	dbms_output.put_line('v_day(1) : '||v_day(1));
	dbms_output.put_line('v_day.LIMIT :'||v_day.LIMIT);
	dbms_output.put_line('v_day.COUNT :'||v_day.COUNT);
	dbms_output.put_line('v_day.FIRST :'||v_day.FIRST);
	dbms_output.put_line('v_day.LAST :'||v_day.LAST);
	v_day.TRIM(1);
	dbms_output.put_line('v_day.COUNT :'||v_day.COUNT);
	
	dbms_output.put_line('DELETE will delete entire collection');
	v_day.DELETE;
	dbms_output.put_line('v_day.COUNT :'||v_day.COUNT);
END;
/


DECLARE 
	TYPE v_nested_tab_type IS TABLE OF VARCHAR2(30);
	v_day v_nested_tab_type := v_nested_tab_type(NULL,NULL);
BEGIN
	v_day(1) := 'MON';
	v_day(2) := 'TUE';
	v_day.EXTEND(1);
	v_day(3) := 'WED';

	dbms_output.put_line('v_day.COUNT :'||v_day.COUNT);
	v_day.DELETE(2);
	dbms_output.put_line('v_day.COUNT :'||v_day.COUNT);
	dbms_output.put_line('v_day.PRIOR(3) :'||v_day.PRIOR(3));
	dbms_output.put_line('v_day.NEXT(1) :'||v_day.NEXT(1));
	IF v_day.EXISTS(2) THEN
		dbms_output.put_line('v_day(2) :'||v_day(2));
	ELSE
		dbms_output.put_line('----- ELEMENT NOT EXISTS -------');
	END IF;
END;
/
