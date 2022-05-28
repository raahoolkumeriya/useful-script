/*
|	Program: Object Type 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

/*
CREATE OR REPLACE TYPE t_person AS OBJECT (
	first_name 	VARCHAR2(30),
	last_name 	VARCHAR2(30),
	date_of_birth	DATE,
	MEMBER FUNCTION get_age RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY t_person AS 
	MEMBER FUNCTION get_age RETURN NUMBER AS
	BEGIN
		RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12);
	END get_age;
END;
/


CREATE TABLE people (
	id NUMBER(10) NOT NULL,
	person	t_person
);


INSERT INTO people (id,person)
	VALUES (1,t_person('Raahool','Kumeriya', TO_DATE('01/01/2022','DD/MM/YYYY')));

COMMIT;
 


DECLARE
	l_person t_person;
BEGIN
	l_person := t_person('jane','Doe',TO_DATE('01/01/2022','DD/MM/YYYY'));
	INSERT INTO people (id,person)
		VALUES(2, l_person);
	COMMIT;
END;
/


*/


SELECT p.id,
	p.person.first_name,
	p.person.get_age() AS age
FROM 	people p;

