/*
|	Program: Collection Methods 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

DECLARE
	TYPE v_array_type IS VARRAY(7) OF VARCHAR2(30);
	v_day v_array_type := v_array_type(NULL,NULL,NULL);
BEGIN
	v_day(1) := 'monday';
	v_day(2) := 'tuesday';
	v_day(3) := 'wednesday';
	dbms_output.put_line(v_day(1) ||' ' || v_day(2) || ' '|| v_day(3));
	dbms_output.put_line('Limit will get value for VARRAY(7) from define part');
	dbms_output.put_line('LIMIT : '|| v_day.LIMIT);
	dbms_output.put_line('Count will get value for the initlization v_array_type(NULL,NULL,NULL)');
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
	dbms_output.put_line('First will give the subscript of first element');
	dbms_output.put_line('FIRST : '|| v_day.FIRST);
	dbms_output.put_line('Last will give the subscript of Last element initliazed');
	dbms_output.put_line('LAST : '|| v_day.LAST);
	dbms_output.put_line('TRIM will delete the last elements base on the parameter to trim()');
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
	v_day.TRIM(2);
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
	
END;
/

DECLARE
        TYPE v_array_type IS VARRAY(7) OF VARCHAR2(30);
        v_day v_array_type := v_array_type(NULL,NULL,NULL);
BEGIN
        v_day(1) := 'monday';
        v_day(2) := 'tuesday';
        v_day(3) := 'wednesday';
      	
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
	dbms_output.put_line('Delete will delete all the elements from arrray');
	v_day.DELETE;	
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
END;
/

prompt ----------------------------------------------------;
prompt We CANNOT delete specific element from VAARAY;
prompt LIMIT is specific to VAARRAY ;
prompt ----------------------------------------------------;


DECLARE
        TYPE v_array_type IS VARRAY(7) OF VARCHAR2(30);
        v_day v_array_type := v_array_type(NULL,NULL,NULL);
BEGIN
        v_day(1) := 'monday';
        v_day(2) := 'tuesday';
        v_day(3) := 'wednesday';
	dbms_output.put_line('COUNT : '|| v_day.COUNT);
	v_day.EXTEND(2);
	dbms_output.put_line('COUNT : '|| v_day.COUNT);

	dbms_output.put_line('PRIOR : '|| v_day.PRIOR(2));
	dbms_output.put_line('NEXT : '|| v_day.NEXT(2));

END;
/	
