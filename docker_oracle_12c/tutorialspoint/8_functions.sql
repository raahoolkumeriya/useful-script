/*
|	Program: Function 
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION totalCustomers
RETURN NUMBER 
IS
	total NUMBER(2) := 0;
BEGIN
	SELECT count(*) 
	INTO total
	FROM TP_CUSTOMERS;
	RETURN total;
END;
/

SELECT 'Total no. of Customers : '||totalCustomers as RowReturn FROM DUAL;


DECLARE
	a NUMBER;
	b NUMBER;
	c NUMBER;
	FUNCTION findMax( x IN NUMBER, y IN NUMBER )
	RETURN NUMBER
	IS
		z NUMBER;
	BEGIN
		IF x > y 
		THEN
			z := x;
		ELSE
			z := y;
		END IF;
		RETURN z;
	END;
BEGIN
		a := 23;
		b := 25;
		c := findMax(a, b);
		DBMS_OUTPUT.PUT_LINE('Max number : '||c);
END;
/


prompt Recursive Function

DECLARE
	num NUMBER;
	factorial NUMBER;
	
	FUNCTION fact(x NUMBER)
	RETURN NUMBER
	IS 
		f NUMBER;
	BEGIN
		IF x = 0
		THEN
			f := 1;
		ELSE
			f := x * fact( x - 1 );
		END IF;
		RETURN f;
	END;
BEGIN
	num := 6;
	factorial := fact(num);
	DBMS_OUTPUT.put_line('Factorial of '||num||' is : '|| factorial );
END;
/	

