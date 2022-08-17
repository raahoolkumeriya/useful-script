/*
||	Program: Working with Explicit Cursors 
||	Author: Raahool Kumeriya
||	Change history:
||		15-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     Working with Explicit Cursors		--;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE book_stuff 
	AUTHID DEFINER
IS
	FUNCTION get_book_title ( p_book_id IN books.book_id%TYPE) RETURN NUMBER;
END book_stuff;
/

SHO ERR;

CREATE OR REPLACE PACKAGE BODY book_stuff
IS
	FUNCTION get_book_title ( p_book_id IN books.book_id%TYPE) 
		RETURN NUMBER
	IS
		CURSOR book_cur IS
			SELECT title FROM books;
		l_title_rec book_cur%ROWTYPE;
		retval NUMBER;
	BEGIN
		OPEN book_cur;
		FETCH book_cur INTO l_title_rec;
		IF book_cur%FOUND
		THEN
			IF book_cur.title = 'Learning Oracle PL/SQL'
				THEN retval := 10;
			ELSIF book_cur.title = 'Oracle PL/SQL Programming'
				THEN retval := 1;
			END IF;
		END IF;
		
		CLOSE book_cur;
	
		RETURN retval;
						
	EXCEPTION 
		WHEN OTHERS THEN
			IF book_cur%ISOPEN THEN
				CLOSE book_cur;
			END IF;
	END get_book_title;
END book_stuff;
/

SHO ERR;
