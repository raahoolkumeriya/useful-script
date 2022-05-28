prompt >>> COMPOSITE DATATYPES <<<
prompt - 1. Records
prompt -	- as k/as structure, typically contains a collection of related elements like a normalized database table
prompt - 2. Collections
prompt - 	- Collections are array and lists. 
prompt -- 1. VARRAY 
prompt -	- Index of varray is densely populated, You opt to use a varray when you know the number of itesm that will go in collection before declaring the variable.
prompt -	- VARRY cannot grow in size.
prompt -	- You cannot use DELETE method to remove an element after it is defined.
prompt -- 2. NESTED table
prompt	-	- Index of NESTED table variables is densely populated. You should use nested table when you DON'T know the numebr of items that will go in the collection before declaring the variable. 
prompt -	- NESTED table can grow in size after it is declared.
prompt -- 3. Associative Array / PLSQL table / Index-by Table  
prompt	-	- You can index an associate array with numbers or Unique strings. Index of associate array is SPARSELY populated. is Ideal when you DON'T know the number of items that will go in the collection before declaring the variable. 
prompt -	- It is similar to NESTED table definition. It has one key difference: it specifies how the index is kept


SET SERVEROUTPUT ON;

prompt >>> >>>> records <<<

DECLARE
	TYPE demo_record_type IS RECORD
		( id 	NUMBER 	DEFAULT 1,
		  value VARCHAR2(10) := 'One');
	demo DEMO_RECORD_TYPE;
BEGIN
	dbms_output.put_line('['||demo.id||']['||demo.value||']');
END;
/


prompt >>> >>>> nested records <<<

DECLARE 
	TYPE full_name IS RECORD 
		( first		VARCHAR2(10 CHAR) := 'Raahool',
		  last 		VARCHAR2(10 CHAR) := 'kumeriya');
	TYPE demo_record_type IS RECORD 
		( id 		NUMBER DEFAULT 1,
		  contact	FULL_NAME);
	demo DEMO_RECORD_TYPE;
BEGIN
	dbms_output.put_line('['||demo.id||']');
	dbms_output.put_line('['||demo.contact.first||']['||demo.contact.last||']');
END;
/

prompt >>> >>>> VARRAY Datatypes <<<<

DECLARE
	TYPE number_varray IS VARRAY(10) OF NUMBER;
	list NUMBER_VARRAY := number_varray(1,2,3,4,5,6,7,8,NULL,NULL);
BEGIN
	FOR i IN 1..list.LIMIT LOOP
		dbms_output.put('['||list(i)||']');
	END LOOP;
	dbms_output.new_line;
END;
/

prompt >>> >>>> Nested Table dataType <<<<
DECLARE
	TYPE number_table IS TABLE OF NUMBER;
	list NUMBER_TABLE := number_table(1,2,3,4,5,6,7,8);
BEGIN
	list.DELETE(2);
	FOR i IN 1..list.COUNT LOOP
		IF list.EXISTS(i) THEN
			dbms_output.put('['||list(i)||']');
		END IF;
	END LOOP;
	dbms_output.new_line;
END;
/
 
prompt >>> >>>> Associate array <<<<

DECLARE
	TYPE number_table IS TABLE OF NUMBER
		INDEX BY PLS_INTEGER; 
	list NUMBER_TABLE;
BEGIN
  	FOR i IN 1..6 LOOP
		list(i) := i; -- Explicit assignment required for associative arrays.
	END LOOP;
	list.DELETE(2);
	FOR i IN 1..list.COUNT LOOP
		IF list.EXISTS(i) THEN 
			dbms_output.put('['||list(i)||']');
		END IF;
	END LOOP; 
	dbms_output.new_line;
END; 
/
