/*
|	Program: VARRAYs ( Variable size arrays ) 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -----------------------------------;
prompt -- VARRAYs (varaible size array) --;
prompt -----------------------------------;
prompt Array are use to store the elements of same datatypes;
prompt Variable size array from Zero to declare maximum size;
prompt We can access elements with the variable_name(index).;

prompt --- User-define datatype he we need to follow below steps (extact order) ---;
prompt Define
prompt Declare
prompt Initialize
prompt Assign
prompt Access

DECLARE
	TYPE v_array_type IS VARRAY(7) OF VARCHAR2(100);                           -- Define
	v_array v_array_type := v_array_type(NULL,NULL,NULL,NULL,NULL,NULL,NULL);  -- Declare and Initialize with NULL
BEGIN
		-- Assign 
	v_array(1) := 'MON';
	v_array(2) := 'TUE';
	v_array(3) := 'WED';
	v_array(4) := 'THR';
	v_array(5) := 'FRI';
	v_array(6) := 'SAT';
	v_array(7) := 'SUN';

		-- Access 
	FOR i IN v_array.FIRST .. v_array.LAST 
	LOOP
		dbms_output.put_line('v_array ('||i||') = '||v_array(i));
	END LOOP;
END;
/

prompt ----------------------------------------------------------------;
prompt Whenever you are working with collection you come across ;
prompt EXCEPTIONS:;
prompt > Reference to uninitilized collections;
prompt > Subscript beyond count;
prompt > Subscript outside of limit;
prompt ----------------------------------------------------------------;

prompt --- Subscript beyond count ----;

prompt DECLARE
prompt 		TYPE v_Array_type IS VARRAY(7) OF VARCHAR2(30);
prompt 		v_array v_Array_type := v_Array_type(null);   --- didnot initilized the second 
prompt 	BEGIN
prompt 		v_array(1) := 'MONDAY';
prompt 		v_array(2) := 'TUESDAY';		
prompt		dbms_output.put_line(v_array(1));
prompt END;


prompt ------------------------------------------------;
prompt Initlization at declaration part;
prompt ------------------------------------------------;

DECLARE
	TYPE v_Array_type IS VARRAY(7) OF VARCHAR2(30);
	v_array v_Array_type := v_Array_type(null,null);
BEGIN
	v_array(1) := 'MONDAY';
	v_array(2) := 'TUESDAY';
	dbms_output.put_line(v_array(1));
	dbms_output.put_line(v_array(2));
END;
/

prompt ---------------------------------------------------;
prompt Dynamic initilization at runtime with EXTEND method;
prompt ---------------------------------------------------;

DECLARE
	TYPE v_Array_type IS VARRAY(7) OF VARCHAR2(30);
	v_array v_Array_type := v_Array_type(null);
BEGIN
	v_array(1) := 'MONDAY';
	v_array.EXTEND();
	v_array(2) := 'TUESDAY';
	dbms_output.put_line(v_array(1));
	dbms_output.put_line(v_array(2));
END;
/


prompt --- Reference to uninitilized collections ---;

prompt DECLARE
prompt 		TYPE v_Array_type IS VARRAY(7) OF VARCHAR2(30);
prompt 		v_array v_Array_type;
prompt 	BEGIN
prompt 		v_array(1) := 'MONDAY';
prompt 		v_array(2) := 'TUESDAY';		
prompt		dbms_output.put_line(v_array(1));
prompt END;


prompt --- Subscript outside of limit ---;

prompt DECLARE
prompt 		TYPE v_Array_type IS VARRAY(7) OF VARCHAR2(30);
prompt 		v_array v_Array_type;
prompt 	BEGIN
prompt 		v_array.EXTEND(8);   --- Extend more than the allocaated memeory which is 7
prompt 		v_array(1) := 'MONDAY';
prompt 		v_array(2) := 'TUESDAY';		
prompt		dbms_output.put_line(v_array(1));
prompt END;


