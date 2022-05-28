SET SERVEROUTPUT ON;

DECLARE
	first_day DATE;
	last_day DATE;
BEGIN
	first_day := SYSDATE;
	DBMS_OUTPUT.PUT_LINE('First Day date :'||first_day);
	last_day := ADD_MONTHS(first_day, 6);
	DBMS_OUTPUT.PUT_LINE(last_day);
END;
/

