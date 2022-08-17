/*
|	Program: Pipelined Table Function  
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Pipelined Table Function                  --;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE strings_t IS TABLE OF VARCHAR2(100);
/

CREATE OR REPLACE FUNCTION strings 
	RETURN strings_t PIPELINED
	AUTHID DEFINER
IS
BEGIN
	PIPE ROW('abc');
	RETURN;
END;
/

-- 12.2 or higher dont need TABLE clause

SELECT COLUMN_VALUE my_strings FROM strings()
/
