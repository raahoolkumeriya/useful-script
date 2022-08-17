/*
||	Program: The TABLE pseudofunction 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --  	The TABLE pseudofunction 	  	--;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE list_of_names_t 
	IS TABLE OF VARCHAR2(100);
/

DECLARE 
	happyfamily 	list_of_names_t := list_of_names_t();
BEGIN
	happyfamily.EXTEND(7);
	happyfamily(1) := 'Sanu';
	happyfamily(2) := 'rani';
	happyfamily(3) := 'father';
	happyfamily(4) := 'mother';
	happyfamily(5) := 'rupa';
	happyfamily(6) := 'rutvik';
	happyfamily(7) := 'niyati'; 
	
	FOR rec IN ( SELECT COLUMN_VALUE family_name
			FROM TABLE (happyfamily)
			ORDER BY family_name)
	LOOP
		DBMS_OUTPUT.put_line(rec.family_name);
	END LOOP;
END;
/


CREATE OR REPLACE PACKAGE aa_pkg
    IS
       TYPE strings_t IS TABLE OF VARCHAR2 (100)
          INDEX BY PLS_INTEGER;
END; 
/


/* Populate the collection, then use a cursor FOR loop
       to select all elements and display them. */
DECLARE
       happyfamily   aa_pkg.strings_t;
BEGIN
       happyfamily (1) := 'Me';
       happyfamily (2) := 'You';
       FOR rec IN (  SELECT COLUMN_VALUE family_name
                       FROM TABLE (happyfamily)
                   ORDER BY family_name)
       LOOP
          DBMS_OUTPUT.put_line (rec.family_name);
       END LOOP;
END;
/



/* File on web: 12c_table_pf_with_aa.sql */
    DECLARE
       TYPE strings_t IS TABLE OF VARCHAR2 (100)
          INDEX BY PLS_INTEGER;
       happyfamily   strings_t;
    BEGIN
       happyfamily (1) := 'Me';
       happyfamily (2) := 'You';
       FOR rec IN (  SELECT COLUMN_VALUE family_name
                       FROM TABLE (happyfamily)
                   ORDER BY family_name)
       LOOP
          DBMS_OUTPUT.put_line (rec.family_name);
       END LOOP;
    END;
/

