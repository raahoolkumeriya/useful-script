/*
|	Program: Qualifying Identifier with Subprogram Name 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt -- Qualifying Identifier with Subprogram Name    --;
prompt ---------------------------------------------------;

CREATE OR REPLACE PROCEDURE check_credit ( credit_limit NUMBER ) AS
	rating NUMBER := 3;

	FUNCTION check_rating RETURN BOOLEAN IS
		rating NUMBER := 1;
		over_limit BOOLEAN;
	BEGIN
		IF check_credit.rating <= credit_limit THEN  --- reference global variable
			over_limit := FALSE;
		ELSE
			over_limit := TRUE;
			rating := credit_limit;		     -- reference local variable
		END IF;
		RETURN over_limit;
	END check_rating;
BEGIN
	IF check_rating THEN
		DBMS_OUTPUT.PUT_LINE
			('Credit rating over limit (' || TO_CHAR(credit_limit) || '). '
			|| 'Rating: '|| TO_CHAR(rating));
	ELSE
		DBMS_OUTPUT.PUT_LINE
			('Credit rating OK. '|| 'Rating: '|| TO_CHAR(rating));
	END IF;
END;
/


BEGIN
	check_credit(1);
END;
/
