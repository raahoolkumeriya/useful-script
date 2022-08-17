/*
||	Program: Sorting contents of collections 
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
prompt --    Sorting contents of collections	 	--;
prompt ---------------------------------------------------;

CREATE OR REPLACE TYPE authors_t IS TABLE OF VARCHAR2(100)
/

CREATE TABLE favorite_authors ( 
	author_name	VARCHAR2(200)
);

BEGIN
	INSERT ALL 
		INTO favorite_authors VALUES ('Raahool Kumeriya')
		INTO favorite_authors VALUES ('Ganesh Pando')
		INTO favorite_authors VALUES ('Nitin Kapde')
	SELECT * FROM DUAL;
END;
/

SELECT * FROM favorite_authors;

prompt -->Now I would like to blend this information with data from my PL/SQL program -->;

DECLARE
	scifi_favorite authors_t := authors_t('Chaitanya Shewatkar','Satish Chopde','Summit Kakani');
BEGIN
	DBMS_OUTPUT.put_line('I recommned that you read books by :');
	FOR rec IN ( SELECT COLUMN_VALUE favs
			FROM TABLE ( CAST ( scifi_favorite AS authors_t))
		    UNION 
		    SELECT author_name
			FROM favorite_authors 
			ORDER BY favs )
	LOOP
		DBMS_OUTPUT.put_line(rec.favs);
	END LOOP;
END;
/

prompt ---> I can also apply this technique only to PL/SQL data to sort the contents being retrieved --->;
DECLARE
        scifi_favorite authors_t := authors_t('Chaitanya Shewatkar','Satish Chopde','Summit Kakani');
BEGIN
        DBMS_OUTPUT.put_line('I recommned that you read books by :');
    	FOR rec IN ( SELECT COLUMN_VALUE favs
			FROM TABLE ( CAST (scifi_favorite AS authors_t))
			ORDER BY COLUMN_VALUE)
	LOOP
		DBMS_OUTPUT.put_line(rec.favs);
        END LOOP;
END;
/

	
