/*
|	Program: Object Oriented: Member method
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt ------------------------------------------

prompt MEMBER methods: Used for manipulating the attibutes of hte object
prompt Constructors: Are functions that returns a new object as its value. Every object has a System defined constructor method. the name of constructor is smae as the object type.

prompt ------------------------------------------

prompt Comparision methods: Used for comparing objects.
prompt ---> Map method:  is a Function implemented in such a way that its depends upon the value of the attibutes. 
prompt ---> Order method : Implements some internal logic for comparing two objects 

prompt -- Using Map method

-- object 
CREATE OR REPLACE TYPE rectangle AS OBJECT 
	(	lenght	NUMBER
	,	width	NUMBER
	,	MEMBER FUNCTION	enlarge(inc NUMBER) RETURN rectangle
	,	MEMBER PROCEDURE display
	, 	MAP MEMBER FUNCTION measure RETURN NUMBER
);
/

show errors


-- object body 
CREATE OR REPLACE TYPE BODY rectangle AS 
	MEMBER FUNCTION enlarge(inc NUMBER) RETURN rectangle IS
	BEGIN
		RETURN rectangle(self.lenght + inc, self.width + inc);
	END enlarge;
	
	MEMBER PROCEDURE display IS
	BEGIN
		DBMS_OUTPUT.put_line('Length : '
					|| lenght
					|| ' Width : '
					|| width);
	END display;
	
	MAP MEMBER FUNCTION measure RETURN NUMBER IS
	BEGIN
		RETURN (SQRT(lenght*lenght + width*width));
	END measure;
END;
/

show errors

DECLARE
	r1 rectangle;
	r2 rectangle;
	r3 rectangle;
	inc_factor NUMBER := 5;
BEGIN
	r1 := rectangle(3,4);
	r2 := rectangle(5,7);
	r3 := r1.enlarge(inc_factor);
	r3.display;
	IF ( r1 > r2 ) THEN  -- calling measure method
		r1.display;
	ELSE
		r2.display;
	END IF;
END;
/	
	
	
