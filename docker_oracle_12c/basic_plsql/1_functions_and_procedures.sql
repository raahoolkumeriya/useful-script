prompt FUNCTION & PROCEDURES
prompt -- named PLSQL bloacks, can deployed as standalone subroutines or as components in packages. 

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION add_three_numbers
 ( a NUMBER := 0, b NUMBER := 0, c NUMBER := 0 ) RETURN NUMBER IS
BEGIN
	RETURN a + b + c;
END;
/

prompt -- Positional Notation
BEGIN
	dbms_output.put_line(add_three_numbers(3,4,5));
END;
/

prompt "----------------"
prompt NOTE: PLS-00312: a positional parameter association may not follow a named
prompt "----------------"
prompt -- Named Notation
BEGIN
	dbms_output.put_line(add_three_numbers(c => 4, b => 5, a => 3));
END;
/

prompt -- Mixed Notation
BEGIN
	dbms_output.put_line(add_three_numbers(4, c=> 4, b => 5));
END;
/

prompt -- Exclusionary Notation
BEGIN
	dbms_output.put_line(add_three_numbers(4, b => 5));
END;
/

prompt -- SQL call Notation
SELECT add_three_numbers(3, c => 4, b => 5) FROM DUAL;

prompt -- DETERMINISTIC 
CREATE OR REPLACE FUNCTION pv
( future_value	NUMBER
, periods 	NUMBER
, interest 	NUMBER)
RETURN NUMBER DETERMINISTIC IS
BEGIN
	RETURN future_value / ((1 + interest)**periods);
END pv;
/


prompt -- CALL statement
VARIABLE result NUMBER;
CALL pv(future_value => 10000,periods => 5,interest => 6) INTO :result;
COLUMN money_today FORMAT 9,999.90;
SELECT :result AS money_today FROM dual;


