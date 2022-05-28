SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE calc_totals ( fudge_factor_in IN NUMBER )
IS
	subtotal NUMBER := 0;

	/* beginning of nested block ( in this case a procedure). Notice
	| we're completely inside the declaration section of clac_totals.
	*/

	PROCEDURE compute_running_total ( increment_in IN PLS_INTEGER )
	IS
	BEGIN
		/* subtotal, declare above, is both in scope and visible */
		subtotal := subtotal + increment_in * fudge_factor_in;
	END;
	/* End of nested block */
	
    BEGIN
	FOR month_idx IN 1..12
	LOOP
		compute_running_total( month_idx );
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Fudged total for years :'|| subtotal);
    END;
/


show errors;

EXECUTE calc_totals(1.0);

