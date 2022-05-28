SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE calc_totals
IS
	year_total	NUMBER;
BEGIN
	year_total := 0;
	
	-- Begining of nested block
	DECLARE
		month_total NUMBER;
	BEGIN
		month_total := year_total / 12 ;
		DBMS_OUTPUT.PUT_LINE(month_total);
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.PUT_LINE('Exception occurs here!');
	END set_month_total;
	-- End of nested block
END;
/

BEGIN
	calc_totals;
END;
/

show errors
