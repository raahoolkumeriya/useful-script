/*
||	Author: Raahool Kumeriya
||	
||	Purpose: Oracle PLSQL learning  
||
||	Change history:
||	Date		Who		Description
||	----------	----------	-----------------------------------
||	26-JUN-2022  	codelocked	Program Created
*/

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			Oracle PLSQL Docs		  ;
prompt ---------------------------------------------------;

-- package implmentation / body
create or replace package body learning_pkg 
IS
	-- Processing Query Result Rows One at a Time
        procedure precessing_one_row_at_a_time
	is
		BEGIN
        		DBMS_OUTPUT.put_line('>>>>>> precessing_one_row_at_a_time <<<<<<<' );
			FOR someone IN ( SELECT * FROM HR.employees
					WHERE employee_id < 120
					ORDER BY employee_id)
			LOOP
				DBMS_OUTPUT.PUT_LINE('First Name = '||someone.first_name||
						     ', Last Name = '||someone.last_name);
			END LOOP;
	END precessing_one_row_at_a_time;

	
	-- Qualifying Identifier with Subprogram Name
        procedure check_credit ( credit_limit NUMBER)
	IS
		rating 	NUMBER := 3;
		
		FUNCTION check_rating RETURN BOOLEAN 
		IS
			rating 	NUMBER := 1;
			over_limit BOOLEAN;
		BEGIN
			IF check_credit.rating <= credit_limit THEN  -- reference global variable
				over_limit := FALSE;
			ELSE
				over_limit := TRUE;
				rating := credit_limit;		     -- reference local variable
			END IF;
			RETURN over_limit;
		END check_rating;
	BEGIN
        	DBMS_OUTPUT.put_line('>>>>>> check_credit <<<<<<<' );
		IF check_rating THEN
			DBMS_OUTPUT.put_line('Credit rating over limit (' || TO_CHAR(credit_limit) ||'). '
					|| ' Rating: '|| TO_CHAR(rating));
		ELSE
			DBMS_OUTPUT.put_line('Credit rating Ok. ' || ' Rating: '|| TO_CHAR(rating));
		END IF;
	END check_credit;


	procedure show_inquiry_directive 
	IS
		i 	PLS_INTEGER;
	BEGIN
		DBMS_OUTPUT.put_line('>>>>> show_inquiry_directive <<<<<');
		DBMS_OUTPUT.put_line('Inside show_inquiry_directive');
		i := $$PLSQL_LINE;
		DBMS_OUTPUT.put_line('i = ' || i);
		DBMS_OUTPUT.put_line('$$PLSQL_LINE = ' || $$PLSQL_LINE);
		DBMS_OUTPUT.put_line('$$PLSQL_UNIT = ' || $$PLSQL_UNIT);
		DBMS_OUTPUT.put_line('$$PLSQL_UNIT_OWNER = ' || $$PLSQL_UNIT_OWNER);
		DBMS_OUTPUT.put_line('$$PLSQL_UNIT_TYPE = ' || $$PLSQL_UNIT_TYPE);
	END show_inquiry_directive;

END learning_pkg;
/



show errors;




	


