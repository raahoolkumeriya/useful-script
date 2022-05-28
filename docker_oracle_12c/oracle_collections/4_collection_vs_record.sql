/*
|	Program: Collections vs RECORD 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ------------------------------;
prompt --        Collections       --;
prompt ------------------------------;

prompt A collection is an ordered group of logically related elements;


prompt COLLECTION vs RECORD;
prompt -- In collection, the internal components always have the same data types and are called Elements.;
prompt -- In record, the internal components can have different data types and are called Fields.;

DECLARE
	TYPE address_rec_type IS RECORD(emp_name	VARCHAR2(100),
					street		VARCHAR2(100),
					city		VARCHAR2(100),
					state 		VARCHAR2(100),
					country		VARCHAr2(100),
					pin		NUMBER);
	lv_address address_rec_type;
BEGIN
	lv_address.emp_name := 'raahool';
	lv_address.street   := 'Nagar road';
	lv_address.city	    := 'Pune';

	dbms_output.put_line(lv_address.emp_name||' ,'||lv_address.street);
END;
/


DECLARE
	TYPE v_array_type IS VARRAY(7) OF VARCHAR2(30);
	v_day v_array_type := v_array_type(NULL,NULL,NULL,NULL,NULL,NULL,NULL);
BEGIN
	v_day(1) := 'MONDAY';
	v_day(2) := 'TUESDAY';
	v_day(3) := 'WEDNESDAY';
	v_day(4) := 'THURSDAY';
	v_day(5) := 'FRIDAY';
	v_day(6) := 'SATURDAY';
	v_day(7) := 'SUNDAY';
	
	FOR i IN 1..7
	LOOP
		dbms_output.put_line('v_day ('||i|| ') : '|| v_day(i));
	END LOOP;
END;
/ 
