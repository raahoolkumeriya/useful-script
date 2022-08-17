/*
|	Program: Stored Package 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE my_package AS
	PROCEDURE display_number (
		p_lower IN NUMBER,
		p_upper IN NUMBER);
	
	FUNCTION difference (
                p_lower IN NUMBER,
                p_upper IN NUMBER)
                RETURN NUMBER;
END;
/

CREATE OR REPLACE PACKAGE BODY my_package AS
	
	PROCEDURE display_number (
                p_lower IN NUMBER,
                p_upper IN NUMBER) 
	AS 
		BEGIN
			FOR i in p_lower..p_upper LOOP
				DBMS_OUTPUT.PUT_LINE(i);
			END LOOP;
		END;

	FUNCTION difference (
                p_lower IN NUMBER,
                p_upper IN NUMBER)
                RETURN NUMBER 
	AS
		BEGIN
			RETURN p_upper - p_lower;
		END;
END;
/

prompt ---------------------------------;
EXECUTE my_package.display_number(2,6);

VARIABLE l_result NUMBER
BEGIN
	:l_result := my_package.difference(2,6);
END;
/

PRINT l_result 
