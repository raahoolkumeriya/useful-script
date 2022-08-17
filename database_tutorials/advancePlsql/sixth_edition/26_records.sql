/*
|	Program: RECORDS 
|	Author: Raahool Kumeriya
|	Change history:
|		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		RECORD				--;
prompt ---------------------------------------------------;

DECLARE
	my_book		books%ROWTYPE;
BEGIN
	SELECT * INTO my_book
	FROM books 
	WHERE book_id = 1;
	DBMS_OUTPUT.put_line(my_book.title);
END;
/

prompt ---------------------------------------------------;
prompt --     		OWN RECORD			--;
prompt ---------------------------------------------------;

DECLARE
	TYPE author_title_rt IS RECORD (
		author	books.author%TYPE,
		title	books.title%TYPE
	);
	l_book_info	author_title_rt;
BEGIN
	SELECT author, title INTO l_book_info
	FROM books WHERE book_id = 3;
	DBMS_OUTPUT.put_line(l_book_info.author || ' - ' || l_book_info.title);
END;
/

prompt ---------------------------------------------------;
prompt --     		Declaring RECORDs		--;
prompt ---------------------------------------------------;
prompt o Table-Based Record;
prompt ---> use %ROWTYPE with table to declare a record;
prompt ---> one_book	books%ROWTYPE;
prompt ---------------------------------------------------;
prompt o Cursor-based Record;
prompt ---> use %ROWTYPE with explicit cursor or cursor variable; 
prompt ---> CURSOR my_book_cur IS SELECT * FROM books;
prompt ---> one_sf_book my_book_cur%ROWTYPE;
prompt ---------------------------------------------------;
prompt o Programmer-defined Record; 
prompt ---> Use TYPE..RECORD statement to define record;
prompt ---> TYPE book_info_rt IS RECORD ( author books.author%TYPE,
prompt ------------------------------  category VARCHAR2(100),
prompt ------------------------------  total_pages_count POSITIVE);
prompt ---> steven_as_author book_info_rt;	
prompt ---------------------------------------------------;

