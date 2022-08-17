/*
|	Program: Generate Random Strings 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    Generate Random Strings with NESTED Tables --;
prompt ---------------------------------------------------;


CREATE OR REPLACE TYPE strings_t IS TABLE OF VARCHAR2(100);
/

CREATE OR REPLACE FUNCTION random_strings ( count_in IN INTEGER )
	RETURN strings_t
	AUTHID DEFINER
IS
	l_strings	strings_t := strings_t();
BEGIN
	l_strings.EXTEND(count_in);
	
	FOR i IN 1..count_in
	LOOP
		l_strings(i) := DBMS_RANDOM.string ('u', 10);
	END LOOP;
	
	RETURN l_strings;
END;
/

DECLARE
	l_strings strings_t := random_strings (5);
BEGIN
	FOR i IN 1..l_strings.COUNT
	LOOP
		DBMS_OUTPUT.put_line(l_strings(i));
	END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt --   Calling PLSQL Function  wiht SQL query      --;
prompt ---------------------------------------------------;

SELECT 'Random = '||COLUMN_VALUE my_string FROM TABLE ( random_strings(5));
/

SELECT e.employee_name 
	FROM TABLE (random_strings(3)) rs, employees e
WHERE LENGTH(e.employee_name) <= LENGTH(COLUMN_VALUE);
/

SELECT e.employee_name
FROM employees e
WHERE ROWNUM < 4
UNION ALL
SELECT rs.COLUMN_VALUE FROM TABLE ( random_strings(3)) rs;
/

prompt ----------------------------------------------------------;
prompt Rec coming from DBMS buffer and not SQL loader;
prompt ----------------------------------------------------------;

BEGIN
	FOR rec IN ( SELECT COLUMN_VALUE my_String FROM TABLE ( random_strings(5)))
	LOOP
		DBMS_OUTPUT.put_line(rec.my_String);
	END LOOP;
END;
/
