/*
|	Program: PLSQL Engine and SQL engine 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --  PLSQ Function can not be resolve by SLQ engine  --;
prompt ---------------------------------------------------;
prompt -- Both engine are tightly intergeated but.;

prompt ---------------------------------------------------;
prompt -- 		TABLE Function 			--;
prompt --> Function return collection;
prompt --> Call function inside TABLE Clause;
promtp --> Collection type and Funciton must be known to SQL;
prompt --> Use within SLECT statement like any table or VIew!;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE tf 
	AUTHID DEFINER
IS
	FUNCTION random_strings ( count_in IN INTEGER )
		RETURN strings_t;

	FUNCTION just_number 
		RETURN NUMBER;
END;
/

show errors;

CREATE OR REPLACE PACKAGE BODY tf 
IS
	FUNCTION random_strings ( count_in IN INTEGER )
                RETURN strings_t 
	IS
		l_strings strings_t := strings_t();
	BEGIN
		l_strings.EXTEND(count_in);
	
		FOR indx IN 1 .. count_in
		LOOP
			l_strings(indx) := DBMS_RANDOM.string('u',10);
		END LOOP;
		RETURN l_strings;
	END;

	FUNCTION just_number
		RETURN NUMBER 
	IS
	BEGIN
		RETURN 1;
	END;

END;
/

show errors;

prompt ---------------------------------------------------;
prompt -- Execute package function with SQL query 	--;
prompt ---------------------------------------------------;

SELECT tf.just_number FROM DUAL
/

prompt ---------------------------------------------------;
prompt SQL engine dosent knwo the collection define inside the package hence it raise invalid datatye;
prompt we need to create teh collection type at schema level to handle this error;
prompt ---------------------------------------------------;

SELECT COLUMN_VALUE my_String FROM TABLE (tf.random_strings(5))
/
