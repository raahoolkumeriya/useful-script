/*
|	Program: Returnign mUltiple columns 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   Returning mUltiple columns			--;
prompt ---------------------------------------------------;

CREATE OR REPLACE FUNCTION animal_family (dad_in animal_ot , mom_in animal_ot)
RETURN animal_nt
	AUTHID DEFINER
IS
	l_family	animal_nt := animal_nt(dad_in, mom_in);
BEGIN
	FOR idx IN 1..
			CASE mom_in.species
				WHEN 'RABBIT' THEN 12
				WHEN 'DOG' THEN 4
				WHEN 'KANGAROO' THEN 1
			END
	LOOP
		l_family.EXTEND;
		l_family(l_family.LAST) := animal_ot('BABY'||idx,
							mom_in.species,
							ADD_MONTHS(SYSDATE, -1 * DBMS_RANDOM.VALUE(1,6)));
	END LOOP;
	RETURN l_family;
END;
/
 
show errors;

SELECT * -- name, species, date_of_birth 
	FROM TABLE (
		animal_family ( animal_ot ('Hoppy', 'RABBIT', SYSDATE - 500),
				animal_ot ('Hippy', 'RABBIT', SYSDATE - 300)))
/

ROLLBACK;

SELECT * FROM ANIMALS;

INSERT INTO animals
	SELECT name,species, date_of_birth
		FROM TABLE (
                animal_family ( animal_ot ('Bod', 'KANGAROO', SYSDATE - 500),
                                animal_ot ('Sally', 'KANGAROO', SYSDATE - 300)))
/

SELECT * FROM ANIMALS;
