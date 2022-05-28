--------------------------------------
prompt >>> Lexical Delimiters <<<
prompt   Assignment := 
prompt   Association : & % => . @
prompt   Concatenation ||
prompt   Comparison  =  -  <>  !=  ^=  >  <  >=  <= 
prompt   delimiter ' (  ) ,  <<  >>  --  /*  */  " 
prompt   Math 	+  /  ** *  - 
prompt   Statement ;
prompt
--------------------------------------

SET SERVEROUTPUT ON;

-- Session-level variable
VARIABLE my_string VARCHAR2(30);

BEGIN
	:my_string := 'A string literal.';
END;
/

SELECT :my_string FROM dual;

-- Use of session level variable in another PLSQL block program

BEGIN
	dbms_output.put_line('Inside another PLSQL block program :'||:my_string);
END;
/

-------------------------------------------------
prompt >>> LITERALS  <<<

DECLARE
	-- Charater Literals
	a CHAR(2) := 'a';
	-- String Literals
	b VARCHAR2(30) := 'some "quoted" strings';
	-- Numeric Literals
	n NUMBER := 252E2;
	d_value BINARY_DOUBLE := 2.0d;  -- this assign a double of 2
	f_value BINARY_FLOAT := 2.0f; -- this assign a float of 2
	-- Boolean literals
	bool_v BOOLEAN := TRUE;
	-- Date and time literals
	relative_date DATE :='01-JUN-07'; -- This assigns 01-JUN-2007.
	absolute_date DATE := '01-JUN-1907'; -- This assigns 01-JUN-1907.

	date_1 VARCHAR2(20) := TO_DATE('01-JUN-07');             -- Default format mask.
	date_2 VARCHAR2(20) := TO_DATE('JUN-01-07','MON-DD-YYYY'); -- Override format mask.
BEGIN
	dbms_output.put_line('Charater Literals : ' || a);	
	dbms_output.put_line('String literals : ' || b);	
	dbms_output.put_line('Numeric literals : '|| n);	
	dbms_output.put_line('NUmeric literals - binary double : '|| d_value);	
	dbms_output.put_line('Numeric literals - binary float : '|| f_value);	
	dbms_output.put_line('Date and time literals');	
	dbms_output.put_line(relative_date );	
	dbms_output.put_line(absolute_date);	
	dbms_output.put_line(date_1);	
	dbms_output.put_line(date_2);
END;
/
