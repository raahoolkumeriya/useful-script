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


DECLARE
	CURSOR book_cur IS 
		SELECT * FROM books;
	book_rec  book_cur%ROWTYPE;
BEGIN
	OPEN book_cur;
	LOOP
		EXIT WHEN book_cur%NOTFOUND;
		FETCH book_cur INTO book_rec;
		DBMS_OUTPUT.put_line(
				book_rec.book_id
				||'^'||book_rec.isbn
				||'^'||book_rec.title
				||'^'||book_rec.summary
				||'^'||book_rec.author
				||'^'||book_rec.date_published
				||'^'||book_rec.page_count);
	END LOOP;
	CLOSE book_cur;
	IF book_cur%ISOPEN THEN
		DBMS_OUTPUT.put_line('Cur is OPEN');
	ELSE 
		DBMS_OUTPUT.put_line('Cur is CLOSED');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.put_line('No data found. ');
		RAISE;
	
	WHEN OTHERS THEN
		IF book_cur%ISOPEN THEN
			CLOSE book_cur;
		END IF;
END;
/


BEGIN
	FOR indx IN ( SELECT * FROM employees) 
	LOOP	
		DBMS_OUTPUT.put_line(
				indx.employee_id
				||'~'||indx.employee_name
				||'~'||indx.job
				||'~'||indx.MANAGER_ID
				||'~'||indx.hiredate
				||'~'||indx.salary
				||'~'||indx.commission
				||'~'||indx.DEPARTMENT_ID);
	END LOOP;
END;
/

