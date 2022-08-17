/*
||	Program: Nested Table Multiset Operations 
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
prompt --     	Nested Table Multiset Operations	--;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE authors_pkg
	AUTHID DEFINER
IS 
	amravati_author  	strings_nt := strings_nt('Chaitanya S','Nitin K','Akshay T','Raahool K');
	buldana_author  	strings_nt := strings_nt('Ganesh P','Pawan N','Satish C');
	nagpur_author		strings_nt := strings_nt('Raahool K', 'Aniket P','Dinesh B');
	cg_author		strings_nt := strings_nt('Akanksha O','Priyanka M','Raahool K');

	PROCEDURE show_authors (
		p_title_in 	IN VARCHAR2,
		p_authors_in	IN strings_nt
	);
END;
/

show errors;

CREATE OR REPLACE PACKAGE BODY authors_pkg
IS
	PROCEDURE show_authors ( p_title_in IN VARCHAR2, p_authors_in IN strings_nt) 
	IS
	BEGIN
		DBMS_OUTPUT.put_line(p_title_in);
		FOR indx IN p_authors_in.FIRST .. p_authors_in.LAST
		LOOP
			DBMS_OUTPUT.put_line(indx || ' = '|| p_authors_in(indx));
		END LOOP;
	DBMS_OUTPUT.put_line('_');
	END show_authors;
END authors_pkg;
/

SHOW ERRORS;


prompt ---------------------------------------------------;
prompt -- Testing Equality and Membership of Nested Tables;
prompt ---------------------------------------------------;

DECLARE
       	TYPE clientele IS TABLE OF VARCHAR2 (64);

	group1  clientele := clientele ('Customer 1', 'Customer 2');
	group2 clientele := clientele ('Customer 1', 'Customer 3');
	group3 clientele := clientele ('Customer 3', 'Customer 1');
BEGIN
       IF group1 = group2
       THEN
          DBMS_OUTPUT.put_line ('Group 1 = Group 2');
       ELSE
          DBMS_OUTPUT.put_line ('Group 1 != Group 2');
       END IF;
       IF group2 != group3
       THEN
          DBMS_OUTPUT.put_line ('Group 2 != Group 3');
       ELSE
          DBMS_OUTPUT.put_line ('Group 2 = Group 3');
       END IF;
END;
/


prompt -----------------------------------------------------------;
prompt -- 	Performing High-Level Set Operations		--;
prompt -----------------------------------------------------------;

DECLARE 
	our_authors	strings_nt := strings_nt();
BEGIN
	our_authors := authors_pkg.amravati_author
			MULTISET UNION authors_pkg.nagpur_author;
	authors_pkg.show_authors('Amravati and Nagpur', our_authors);

	our_authors := authors_pkg.amravati_author
                        MULTISET UNION DISTINCT authors_pkg.nagpur_author;
        authors_pkg.show_authors('Amravati and Nagpur with DISTICT', our_authors);

	our_authors := authors_pkg.amravati_author
                        MULTISET INTERSECT authors_pkg.nagpur_author;
        authors_pkg.show_authors('IN COMMON', our_authors);
	
	our_authors := authors_pkg.amravati_author
                        MULTISET EXCEPT authors_pkg.nagpur_author;
        authors_pkg.show_authors(q'[ONLY Amravati's]', our_authors);
END;
/

