/*
|	Program: Creating and Invoking Pipelined Table Function 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt -- Creating and Invoking Pipelined Table Function --;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE pkg1
AS
	TYPE numset_t IS TABLE OF NUMBER;
	
	FUNCTION f1(x NUMBER )
	RETURN numset_t PIPELINED;
END pkg1;
/


CREATE OR REPLACE PACKAGE BODY pkg1 
AS
	-- Function f1 returns a collection of elements (1,2,3...x)
	FUNCTION f1(x NUMBER ) RETURN numset_t PIPELINED 
	IS 
	BEGIN
		FOR i IN 1..x LOOP
			PIPE ROW(i);
		END LOOP;
		RETURN;
	END f1;
END pkg1;
/

SELECT * FROM TABLE(pkg1.f1(5));

