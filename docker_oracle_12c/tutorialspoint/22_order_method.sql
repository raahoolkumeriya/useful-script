/*
|	Program: Object Oriented: member method : Order
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TYPE rectangle AS OBJECT
	( 	length	NUMBER
	,	width	NUMBER
	,	MEMBER	PROCEDURE	display
	, 	ORDER MEMBER FUNCTION measure ( r rectangle) RETURN NUMBER
);
/

show errors;

CREATE OR REPLACE TYPE BODY rectangle AS
	MEMBER PROCEDURE display IS
	BEGIN
		DBMS_OUTPUT.put_line('Length : '||length || ' and Width : '|| width);
	END display;

	ORDER MEMBER FUNCTION measure(r rectangle) RETURN NUMBER IS
	BEGIN
		IF (SQRT(self.length*self.length + self.width* self.width) > (SQRT(r.length*r.length + r.width*r.width))) THEN
			RETURN(1);
		ELSE
			RETURN(-1);
		END IF;
	END measure;
END;
/


sho err
prompt -----------------------------

DECLARE
	r1 rectangle;
	r2 rectangle;
BEGIN
	r1 := rectangle(23,44);
	r2 := rectangle(15,17);
	r1.display;
	r2.display;
	IF ( r1 > r2 ) THEN   -- calling measure function
		r1.display;
	ELSE
		r2.display;
	END IF;
END;
/

