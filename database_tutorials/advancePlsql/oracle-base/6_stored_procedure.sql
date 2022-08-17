/*
|	Program: Stored procedure 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/


CREATE OR REPLACE PROCEDURE display_numbers (
	p_lower IN NUMBER,
	p_upper IN NUMBER)
AS
	BEGIN
		FOR i in p_lower..p_upper LOOP
			DBMS_OUTPUT.PUT_LINE(i);
		END LOOP;
	END;
/


SET SERVEROUTPUT ON;
EXEC display_numbers(2,6);

