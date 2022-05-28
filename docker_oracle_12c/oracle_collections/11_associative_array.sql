/*
|	Program: Associative array 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --	ASSOCIATIVE ARRAY 			--;
prompt ---------------------------------------------------;

prompt -------------------------+-----------------------------+------------------------;
prompt "        VARRAY 		|	NESTED TABLES	      |   ASSOCIATIVE ARRAY   ";
prompt -------------------------+-----------------------------+------------------------;
prompt " Upper bound is fixed   | No maximum upper bound      | Index is not sequencial";
prompt "			| extend and store as per need|member, its a user-defined";
prompt "			| during runtime  	      | value			";
prompt -------------------------+-----------------------------+------------------------;
prompt " Index is predifned &   | Index is predifned & 	      |Index and value part are" ;
prompt " maintian by oracle	| maintian by oracle	      | user-defined		";
prompt -------------------------+-----------------------------+------------------------;

prompt formerly known as PLSQL table or INdeX-by table is a set of Key-value pair.;
prompt Similar to hash table;

prompt Define, Declare, Initlize, Assign, Access

DECLARE
	TYPE v_asso_array_type IS TABLE OF VARCHAr2(30)
		INDEX BY VARCHAR2(30);
	v_color_code v_asso_array_type;
BEGIN
	v_color_code('WHITE') := '000,000,000';
	v_color_code('BLACK') := '111,111,111';
	v_color_code('RED')   := '111,110,110';
	v_color_code('GREEN') := '001,111,000';
	v_color_code('BLUE')  := '111,111,000';

	dbms_output.put_line('v_color_code(WHITE) : '|| v_color_code('WHITE'));
	dbms_output.put_line('v_color_code(RED) : '|| v_color_code('RED'));
	dbms_output.put_line('v_color_code(BLUE) : '|| v_color_code('BLUE'));

	dbms_output.put_line('LIMIT, TRIM, EXTEND  are NOT availbel for Associativ array');
	dbms_output.put_line(' Asscociate does not preseve sorted order, it order with keys');
	dbms_output.put_line('v_color_code.FIRST : '||v_color_code.FIRST);
	dbms_output.put_line('v_color_code.LAST : '||v_color_code.LAST);
	dbms_output.put_line('v_color_code.COUNT : '||v_color_code.COUNT);
	dbms_output.put_line('v_color_code.PRIOR(RED) : '||v_color_code.PRIOR('RED'));
	dbms_output.put_line('v_color_code.NEXT(RED) : '||v_color_code.NEXT('RED'));
	
	IF v_color_code.EXISTS('RED') THEN
		dbms_output.put_line('RED exists.......');
	ELSE
		dbms_output.put_line('------- RED not exists----------');
	END IF;

	v_color_code.delete('YELLOW');	
	dbms_output.put_line('v_color_code.COUNT : '||v_color_code.COUNT);
	
	v_color_code.delete('RED');	
	dbms_output.put_line('v_color_code.COUNT : '||v_color_code.COUNT);
	
	v_color_code.delete;	
	dbms_output.put_line('v_color_code.COUNT : '||v_color_code.COUNT);
	
	IF v_color_code.EXISTS('YELLOW') THEN
		dbms_output.put_line('Yellow exists.......');
	ELSE
		dbms_output.put_line('------- YELLOW not exists----------');
	END IF;
END;	
/
