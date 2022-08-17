/*
||	Program: CURSOR basics  
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
prompt --     		CURSOR basics			--;
prompt ---------------------------------------------------;

CREATE OR REPLACE PACKAGE book_utility 
	AUTHID DEFINER
IS
	FUNCTION book_title (p_isbn_in IN books.isbn%TYPE) RETURN books.title%TYPE;

	PROCEDURE remove_from_circulation (p_isbn_in IN books.isbn%TYPE);
	
	PROCEDURE show_book_count;
END book_utility;
/

show errors;


CREATE OR REPLACE PACKAGE BODY book_utility 
IS

	FUNCTION book_title (p_isbn_in IN books.isbn%TYPE)
		RETURN books.title%TYPE
	IS
		return_value books.title%TYPE;
	BEGIN
		SELECT title INTO return_value
		FROM books 
		WHERE isbn = p_isbn_in;
		
		RETURN return_value;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.put_line('Data integrity error for: '||p_isbn_in);
			RAISE;
	END;
	
		
	PROCEDURE remove_from_circulation 
		(p_isbn_in IN books.isbn%TYPE)
	IS
	BEGIN
		DELETE FROM books WHERE isbn = p_isbn_in;
		DBMS_OUTPUT.put_line ('Deleted record : '|| SQL%ROWCOUNT);
	END remove_from_circulation;
	
	PROCEDURE show_book_count
	IS
		l_count	INTEGER;
		l_numfound PLS_INTEGER;
	BEGIN
		SELECT count(*) INTO l_count 
		FROM books;
		DBMS_OUTPUT.put_line ('Total books : '||l_count);
		
		-- take snapshot of attribute value
		l_numfound := SQL%ROWCOUNT;
		
		-- No such book 
		remove_from_circulation('0-000-00000-0');
		
		-- Now I can go back to the previous attribute value
		DBMS_OUTPUT.put_line('Attribute value : '||l_numfound);

	END show_book_count;

END book_utility;
/

show errors;

BEGIN
	DBMS_OUTPUT.put_line(book_utility.book_title('1-56592-335-9'));
	DBMS_OUTPUT.put_line(book_utility.book_title('6592-335-9'));
	book_utility.show_book_count;

END;
/
