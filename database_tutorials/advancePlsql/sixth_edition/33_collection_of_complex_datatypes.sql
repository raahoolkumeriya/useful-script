/*
||	Program: Collections of Complex Datatypes  
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
prompt --   Collections of Complex Datatypes	  	--;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE compensation_pkg 
	AUTHID CURRENT_USER
IS
	TYPE reward_rt IS RECORD (
		nm VARCHAR2(2000), sal NUMBER, comm NUMBER);

	TYPE reward_nnt IS TABLE OF reward_rt INDEX BY PLS_INTEGER;
END compensation_pkg;
/

SHOW ERRORS;

prompt o Declare collection in other programs o;
DECLARE
	l_reward	compensation_pkg.reward_nnt;
BEGIN
	NULL;
END;
/

prompt ------------------------------------------------------------------------;
prompt -- copy data into collections and manipulate them within your program --;
prompt ------------------------------------------------------------------------;
prompt --> Two approches:;
prompt o Embed all collection code in your main porgram;
prompt o Create a sperate package to emcapsulate access to the data in the collection;
prompt ------------------------------------------------------------------------;

CREATE OR REPLACE PACKAGE bidir
	AUTHID DEFINER
IS
	FUNCTION rowforid (p_id_in IN employees.employee_id%TYPE)
		RETURN employees%ROWTYPE;
	
	FUNCTION firstrow RETURN PLS_INTEGER;
	FUNCTION lastrow RETURN PLS_INTEGER;

	FUNCTION rowCount RETURN PLS_INTEGER;
	
	FUNCTION end_of_data RETURN PLS_INTEGER;
	
	PROCEDURE setrow (p_nth IN PLS_INTEGER);
	
	FUNCTION currrow RETURN employees%ROWTYPE;
	
	PROCEDURE nextrow;
	PROCEDURE prevrow;

END;
/

prompt -------------------------------------------------------------;
prompt -- API to read througth the result set for employees table --;
prompt -------------------------------------------------------------;
/*
DECLARE 
	l_employee employees%ROWTYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE(bidir.lastrow);
	LOOP
		EXIT WHEN bidir.end_of_data;
		l_employee := bidir.currrow;
		DBMS_OUTPUT.PUT_LINE(l_employee.EMPLOYEE_NAME);
		bidir.nextrow;
	END LOOP;
	
	bidir.setrow(bidir.lastrow);

	LOOP
		EXIT WHEN bidir.end_of_data;
		l_employee := bidir.currrow;
                DBMS_OUTPUT.PUT_LINE(l_employee.EMPLOYEE_NAME);
		bidir.prevrow;
	END LOOP;
END;
*/


prompt ----------------------------------------------------;
prompt -- Collections of objects and other complex types --;
prompt ----------------------------------------------------;

CREATE OR REPLACE TYPE pet_t 
	AUTHID CURRENT_USER
IS OBJECT (
	tag_no	INTEGER,
	petname	VARCHAR2(60),
	MEMBER FUNCTION set_tag_no ( new_tag_no IN INTEGER ) RETURN pet_t
);
/
SHO ERR;

DECLARE
	TYPE pets_t IS TABLE OF pet_t;   -- Collection NT of object pet_t
	pets pets_t := pets_t(pet_t(1050, 'Sammy'), pet_t(1075, 'Mercury'));
BEGIN
	FOR indx IN pets.FIRST .. pets.LAST 
	LOOP
		DBMS_OUTPUT.put_line(pets(indx).petname);
	END LOOP;
END;
/

prompt ------------------------------------------------;
prompt --	Multilevel Collections 		     --;
prompt ------------------------------------------------;

/*
CREATE OR REPLACE TYPE vet_visit_t 
	AUTHID DEFINER 
IS OBJECT (
		visit_date	DATE,
		reason		VARCHAR2(100)
	);
/
*/

-- Collection of objects type vet_visit_t
CREATE OR REPLACE TYPE vet_visits_t IS TABLE OF vet_visit_t; 
/ 
 
-- With above data structures defined I can create my new object type to maintain information about my pets
CREATE OR REPLACE TYPE pet_t 
	AUTHID DEFINER 
IS OBJECT (
	tag_no	INTEGER,
	petname	VARCHAR2(60),
	petcare	vet_visits_t,
	MEMBER FUNCTION set_tag_no ( new_tag_no IN INTEGER ) RETURN pet_t );
/

DECLARE
	TYPE bunch_of_pets_t
		IS 
			TABLE OF pet_t INDEX BY PLS_INTEGER;
	my_pets bunch_of_pets_t;
BEGIN
	my_pets(1) := pet_t (100, 'Mercury',
				vet_visits_t(vet_visit_t('01-Jan-2001','Clip wings')
					    ,vet_visit_t('01-Apr-2002','Check Cholestrol')
					)
	);
	DBMS_OUTPUT.put_line(my_pets(1).petname);
	DBMS_OUTPUT.put_line(my_pets.COUNT);
	DBMS_OUTPUT.put_line(my_pets(1).petcare.LAST);
END;
/
    
