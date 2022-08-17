SET SERVEROUTPUT ON;
SET LINESIZE 132 PAGESIZE 1000;

CREATE OR REPLACE PACKAGE calculator
AS
	FUNCTION addition ( number_1 IN NUMBER, number_2 IN NUMBER ) RETURN NUMBER;
	FUNCTION substraction ( number_1 IN NUMBER, number_2 IN NUMBER ) RETURN NUMBER;
	FUNCTION multiply ( number_1 IN NUMBER, number_2 IN NUMBER ) RETURN NUMBER;
	FUNCTION division ( number_1 IN NUMBER, number_2 IN NUMBER ) RETURN NUMBER;

END calculator;
/

-- package body
CREATE OR REPLACE PACKAGE BODY calculator
IS
	FUNCTION addition ( number_1 IN NUMBER, number_2 IN NUMBER )
	RETURN NUMBER
	IS
	BEGIN
		RETURN number_1 + number_2;
	END addition;

	FUNCTION substraction (  number_1 IN NUMBER, number_2 IN NUMBER ) 
	RETURN NUMBER
	IS
	BEGIN 
		RETURN number_1 - number_2;
	END;

	FUNCTION multiply (  number_1 IN NUMBER, number_2 IN NUMBER ) 
	RETURN NUMBER
	IS
	BEGIN 
		RETURN number_1 * number_2;
	END;

	FUNCTION division (  number_1 IN NUMBER, number_2 IN NUMBER ) 
	RETURN NUMBER
	IS
	BEGIN 
		RETURN number_1 / number_2;
	EXCEPTION
		WHEN ZERO_DIVIDE THEN
			DBMS_OUTPUT.PUT_LINE('Can''t divide with Zero');
	END;

END calculator;
/


prompt -- ERROR --

show errors

prompt -- TESTING --

SELECT calculator.addition(100,123), calculator.substraction(100,25), calculator.multiply(12,12), calculator.division(100,2) FROM DUAL;

