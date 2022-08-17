/*
|	Program: Traditional Searching, Extracting, and Replacing 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- Traditional Searching, Extracting, and Replacing --;
prompt ---------------------------------------------------;
prompt -- finds the locations of all the commas in a list of names --;
prompt ---------------------------------------------------;

DECLARE
	names		VARCHAR2(60) := 'Raahool,Aniket,Pintu,Sandeep,Chaitu,Ganesh,Satish,Sumya';
	comma_location	NUMBER := 0;
BEGIN
	DBMS_OUTPUT.put_line(names);

	LOOP
		comma_location := INSTR(names,',',comma_location+1);
		EXIT WHEN comma_location = 0;
		DBMS_OUTPUT.put_line(comma_location);
	END LOOP;
END;
/


prompt ---------------------------------------------------;
prompt --	 Let's extract the names instead 	--;
prompt ---------------------------------------------------;

DECLARE
        names           VARCHAR2(60) := 'Raahool,Aniket,Pintu,Sandeep,Chaitu,Ganesh,Satish,Sumya';
        name_adjusted	VARCHAR2(61);
	comma_location  NUMBER := 0;
	prev_location	NUMBER := 0;
	
BEGIN
        DBMS_OUTPUT.put_line(names);
	-- stick a comma after the final name
	name_adjusted := names || ',';
        LOOP
                comma_location := INSTR(names,',',comma_location+1);
                EXIT WHEN comma_location = 0;
                DBMS_OUTPUT.put_line(
			SUBSTR(name_adjusted,
				prev_location + 1,
				comma_location - prev_location - 1 ));
      		prev_location := comma_location;
	END LOOP;
END;
/


prompt ---------------------------------------------------;
prompt --	 Let's try with REPLACE		 	--;
prompt ---------------------------------------------------;

DECLARE
        names           VARCHAR2(60) := 'Raahool,Aniket,Pintu,Sandeep,Chaitu,Ganesh,Satish,Sumya';
BEGIN
	DBMS_OUTPUT.put_line(
		REPLACE(names, ',', chr(10)));
END;
/


prompt ---------------------------------------------------;
prompt --	 	REGEXP_LIEK			--;
prompt ---------------------------------------------------;


DECLARE
        names           VARCHAR2(60) := 'Raahool,Aniket,Pintu,Sandeep,Chaitu,Ganesh,Satish,Sumya';
        name_adjusted   VARCHAR2(61);
        comma_delimited	BOOLEAN;
	j_location	NUMBER;
BEGIN
	-- look for the pattern
	comma_delimited := REGEXP_LIKE(names,'^([a-z ]*,)+([a-z ]*)$', 'i');
	
	-- only do more if we do in fact have a comma-delimited list
	IF comma_delimited THEN
		j_location := REGEXP_INSTR(names, 'R[a-z]*[^aeiou],|R[a-z]*[^aeiou]$');
		DBMS_OUTPUT.put_line(j_location);
	END IF;
END;
/


prompt ---------------------------------------------------;
prompt --	 	REGEXP_SUBSTR			--;
prompt ---------------------------------------------------;

DECLARE
	contact_info VARCHAR2(200) := '
		address:
		1060 W. Addison St.
		Chicago, IL 60613
		home 773-555-5253
	      ';
	phone_pattern  VARCHAR2(90) :=  '\(?\d{3}\)?[[:space:]\.\-]?\d{3}[[:space:]\.\-]?\d{4}';
BEGIN
	DBMS_OUTPUT.PUT_LINE('The phone number is: '||
				REGEXP_SUBSTR(contact_info,phone_pattern,1,1));
END;
/


