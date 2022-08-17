/*
|	Program: Qualifying redclared Global Indentifier with Block label 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -----------------------------------------------------------------;
prompt --   Qualifying redclared Global Indentifier with Block label  --;
prompt -----------------------------------------------------------------;

<<outer>>
DECLARE
	birthdate	DATE := '10-AUG-2000';
BEGIN
	DECLARE
		birthdate 	DATE := '30-AUG-2000';
	BEGIN
		IF birthdate = outer.birthdate THEN
			dbms_output.put_line('Same Birthday');
		ELSE
			dbms_output.put_line('Something different for Birthday');
		END IF;
	END;
END;
/

			
	
