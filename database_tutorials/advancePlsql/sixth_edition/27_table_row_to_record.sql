/*
||	Program: Move data directly from row in a table to a record 
||	Author: Raahool Kumeriya
||	Change history:
||		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --Move data directly from row in a table to a record--;
prompt ---------------------------------------------------;

DECLARE
	/*
	||	Declare a cursor and then defien a record based on that cursor
	||	with the %ROWTYPE attribute.
	*/
	CURSOR book_cur	IS
		SELECT book_id,isbn,title,page_count 
		FROM books;
	books_rec book_cur%ROWTYPE;
BEGIN
	/* Move values directly into record fetching from cursor */
	OPEN book_cur;
	LOOP
		FETCH book_cur INTO books_rec;
		EXIT WHEN book_cur%NOTFOUND;
		DBMS_OUTPUT.put_line(books_rec.book_id||'. '||books_rec.title||' ('||books_rec.isbn||') has pages '||books_rec.page_count);
	END LOOP;
	CLOSE book_cur;

END;
/



prompt ---------------------------------------------------;
prompt --Programmer-Defined TYPE that matched data retrived by implicit cursor--;
prompt ---------------------------------------------------;

DECLARE
	TYPE book_rectype IS RECORD
		( book_id	books.book_id%TYPE,
		  book_name	books.title%TYPE,
		  total_pages	NUMBER
		);
	book_rec	book_rectype;
BEGIN
	/* move values directly into the record */
	SELECT book_id, title, page_count INTO book_rec
	FROM books where book_id = 3;

	DBMS_OUTPUT.put_line(book_rec.book_id||' .'||book_rec.book_name||' has total pages - '|| book_rec.total_pages);

END;
/

