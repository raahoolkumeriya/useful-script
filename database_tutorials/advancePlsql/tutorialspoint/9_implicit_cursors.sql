/*
|	Program: Cursors
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;


DECLARE
	total_rows NUMBER(2);
BEGIN
	UPDATE TP_CUSTOMERS
	SET salary = salary + 500;
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('no customers selected');
	ELSIF SQL%FOUND THEN
		total_rows := SQL%ROWCOUNT;
		DBMS_OUTPUT.PUT_LINE(total_rows ||' customers selected.');
	END IF;
END;
/

