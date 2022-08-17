/*
|	Program: Exception
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt --> System-Defined Exceptions

DECLARE
	c_id	tp_customers.id%TYPE := 8;
	c_name	tp_customers.name%TYPE;
	c_addr	tp_customers.address%TYPE;
BEGIN
	SELECT name, address 
	INTO c_name, c_addr 
	FROM tp_customers
	WHERE id = c_id;

	DBMS_OUTPUT.PUT_LINE('Customer : '
				|| c_name
				|| ' has address details : '
				|| c_addr);
EXCEPTION
	WHEN NO_DATA_FOUND
	THEN
		DBMS_OUTPUT.PUT_LINE('No such customer!');
	WHEN OTHERS 
	THEN
		DBMS_OUTPUT.PUT_LINE('Error');
END;
/


prompt --> User-Define Exceptions

DEFINE cc_id = -6;


DECLARE
	c_id	tp_customers.id%TYPE	:= &cc_id;
	c_name	tp_customers.name%TYPE;
	c_addr	tp_customers.address%TYPE;
	-- user defined exception
	ex_invalid_id	EXCEPTION;
BEGIN
	IF c_id <= 0 
	THEN	
		RAISE ex_invalid_id;
	ELSE
		SELECT name , address
		INTO c_name, c_addr
		FROM tp_customers
		WHERE id = c_id;
		
		DBMS_OUTPUT.PUT_LINE('Customer : '
				|| c_name
				|| ' has address details : '
				|| c_addr);
	END IF;
EXCEPTION
	WHEN ex_invalid_id THEN
		DBMS_OUTPUT.PUT_LINE('ID must be Greater than Zero!');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No such customers');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error');
END;
/


	
