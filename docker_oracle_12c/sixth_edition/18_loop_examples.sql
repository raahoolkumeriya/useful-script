/*
|	Program: Simple loop 
|	Author: Raahool Kumeriya
|	Change history:
|		06-May-2022	Program created.
|*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE display_total_sales ( year_in IN NUMBER )
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE(year_in);
END;
/


CREATE OR REPLACE PROCEDURE display_multiple_years (
	start_year_in 	IN 	PLS_INTEGER,
	end_year_in	IN	PLS_INTEGER
	) 
IS
	l_current_year PLS_INTEGER := start_year_in;
BEGIN
	LOOP
		EXIT WHEN l_current_year > end_year_in;
		display_total_sales ( l_current_year );
		l_current_year := l_current_year + 1;
	END LOOP;
END display_multiple_years;
/


BEGIN
	display_multiple_years(2002, 2004);
END;
/


prompt FOR loop

CREATE OR REPLACE PROCEDURE display_multiple_years (
        start_year_in   IN      PLS_INTEGER,
        end_year_in     IN      PLS_INTEGER
        ) 
IS
BEGIN
	FOR year IN REVERSE start_year_in..end_year_in
	LOOP
		display_total_sales(year);
	END LOOP;
END;
/

EXECUTE display_multiple_years(2020,2022);

prompt Cursor FOR loop

prompt While Loop

CREATE OR REPLACE PROCEDURE display_multiple_years (
        start_year_in   IN      PLS_INTEGER,
        end_year_in     IN      PLS_INTEGER
        )
IS
	l_current_year PLS_INTEGER := start_year_in;
BEGIN
	WHILE ( l_current_year <= end_year_in )
	LOOP
		display_total_sales (l_current_year);
		l_current_year := l_current_year + 1;
	END LOOP;
END display_multiple_years;
/

EXECUTE display_multiple_years( 3000,3002);

