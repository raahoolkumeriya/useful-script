/*
||	Program: The MULTISET pseudofunction 
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
prompt --     	The MULTISET pseudofunction		--;
prompt ---------------------------------------------------;

DROP TYPE color_tab_t FORCE;

CREATE OR REPLACE TYPE color_tab_t AS TABLE OF VARCHAR2(30)
/


CREATE TABLE birds (
       genus VARCHAR2(128),
       species VARCHAR2(128),
       colors color_tab_t,
       PRIMARY KEY (genus, species)
)
NESTED TABLE colors STORE AS colors_tab
/

CREATE TABLE bird_habitats (
       genus VARCHAR2(128),
       species VARCHAR2(128),
       country VARCHAR2(60),
       FOREIGN KEY (genus, species) REFERENCES birds (genus, species)
);


INSERT ALL
	INTO birds VALUES('Circus','Black Harrier',color_tab_t('BLACK','GRAY'))
	INTO bird_habitats VALUES ('Circus','Black Harrier','South Africa')
	INTO bird_habitats VALUES ('Circus','Black Harrier','Botswana')
	INTO bird_habitats VALUES ('Circus','Black Harrier','Namibia')
SELECT * FROM DUAL;

CREATE OR REPLACE TYPE country_tab_t AS TABLE OF VARCHAR2(60);
/


COL genus FORMAT A30;
COL species FORMAT A30;
COL COLORS FORMAT A30;
COL Country_collections FORMAT A70;

SELECT * from birds;
SELECT * from bird_habitats;

SELECT b.genus, b.species,
	CAST (MULTISET ( SELECT bh.country FROM bird_habitats bh
			WHERE   bh.genus = b.genus
			AND     bh.species = b.species)
		AS country_tab_t ) AS Country_collections
	FROM birds b;

prompt --- Handle Multiset in plsql --->;


DECLARE
	CURSOR bird_curs IS 
		SELECT b.genus, b.species,
		CAST (MULTISET ( SELECT bh.country FROM bird_habitats bh
				WHERE 	bh.genus = b.genus
				AND 	bh.species = b.species)
			AS country_tab_t ) AS Country_collections
		FROM birds b;
	bird_row	bird_curs%ROWTYPE;
BEGIN
	OPEN bird_curs;
	FETCH bird_curs INTO bird_row;
		DBMS_OUTPUT.put_line('Genus 	: '|| bird_row.genus);	
		DBMS_OUTPUT.put_line('Species	: '|| bird_row.species);	
	CLOSE bird_curs;
END;
/

