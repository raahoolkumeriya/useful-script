/*
||	Program: Where You Can Use Collections 
||	Author: Raahool Kumeriya
||	Change history:
||		13-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --  	Where You Can Use Collections	   	--;
prompt ---------------------------------------------------;
prompt o 	Collections as components of a record	 o;
prompt ---------------------------------------------------;

-- NESTED Table
CREATE OR REPLACE TYPE color_tab_t IS TABLE OF VARCHAR2(100)
/

DECLARE
	TYPE toy_rec_t IS RECORD (
		manufacturer 		INTEGER,
		shipping_weight_kg 	NUMBER,
		domestic_colors		color_tab_t,
		international_colors	color_tab_t
	);
BEGIN
	null;
END;
/


prompt ---------------------------------------------------;
prompt o 	Collections as program parameter 	 o;
prompt ---------------------------------------------------;
prompt ---> Collection using a Schema-level type <--;
CREATE OR REPLACE TYPE yes_no_t IS TABLE OF CHAR(1);
/

prompt ---> Collection using a parameter to Function or Procedure <--;
CREATE OR REPLACE PROCEDURE act_on_flags ( p_flags_in IN yes_no_t)
IS
BEGIN
	NULL;
END;
/

prompt ---> Collection define in package specification <--;
CREATE OR REPLACE PACKAGE aa_types AUTHID DEFINER
IS 
	TYPE boolean_aat IS TABLE OF BOOLEAN INDEX BY PLS_INTEGER;
END aa_types;
/

show errors;

prompt ---> Collection type reference from package <---;
CREATE OR REPLACE PROCEDURE act_on_flags ( 
	p_flags_in IN aa_types.boolean_aat)
	AUTHID DEFINER
IS 
BEGIN
	null;
END act_on_flags;
/


SHOW ERRORS;

prompt ----> Declaring Collection type in an outer block and then using in inner block <---;
DECLARE
	TYPE birthdates_aat IS VARRAY(10) OF DATE;
	l_dates	birthdates_aat := birthdates_aat();
BEGIN
	l_dates.EXTEND(1);
	l_dates(1) := SYSDATE;

	DECLARE
		FUNCTION earliest_birthdate ( p_list_in IN birthdates_aat ) RETURN DATE
		IS 
		BEGIN
			RETURN null;
		END earliest_birthdate;
	BEGIN
		DBMS_OUTPUT.put_line(earliest_birthdate(l_dates));
	END;
END;
/

show errors;

			
prompt ---------------------------------------------------;
prompt o Collections as datatype of a function return value;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE library_book_t IS TABLE of VARCHAR2(100);
/

CREATE OR REPLACE FUNCTION true_book ( p_whose_id IN VARCHAR2 ) 
	RETURN library_book_t
	AUTHID DEFINER
AS
	l_books library_book_t;
BEGIN
	SELECT TITLE BULK COLLECT INTO l_books
	FROM librarybooks 
	WHERE book_id = p_whose_id;
	
	RETURN l_books;
END;
/

show errors; 

prompt ---------------------------------------------------;
prompt o Collections as Columns in a database tables	  o;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE dependent_birthdate_t AS VARRAY(10) OF DATE;
/

CREATE TABLE employees_tab (
	id 		NUMBER,
	name		VARCHAR2(50),
	dependents_ages dependent_birthdate_t
);

INSERT INTO employees_tab VALUES(10010,'Zaphod Beeblebrox',
		dependent_birthdate_t('12-JAN-1763', '4-JUL-1977', '22-MAR-2021'));
INSERT INTO employees_tab VALUES(10020,'Molly Squiggly', 
		dependent_birthdate_t('14-JUL-1968', '22-MAR-2021'));
INSERT INTO employees_tab VALUES(10030,'Joseph Josephs',
		dependent_birthdate_t());
INSERT INTO employees_tab VALUES(10040,'Zaphod Beeblebrox',
		dependent_birthdate_t('12-JAN-1763', '4-JUL-1977', '22-MAR-2021'));
INSERT INTO employees_tab VALUES(10050,'Zaphod Beeblebrox',
		dependent_birthdate_t('21-SEP-1763'));
SELECT * FROM employees_tab;


CREATE TABLE personality_inventory (
	person_id	NUMBER,
	favorite_colors	color_tab_t,
	date_tested	DATE,
	test_results	BLOB)
     NESTED TABLE favorite_colors STORE AS favorite_colors_st;

	
prompt ---------------------------------------------------;
prompt o Collections as attributes of an Object Type     o;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE auto_spec_t AS OBJECT (
	make		VARCHAR2(30),
	model		VARCHAR2(30),
	available_colors	color_tab_t
);

CREATE TABLE autos=_specs OF auto_spec_t
	NESTED TABLE available_colors STORE AS available_colors_st;

