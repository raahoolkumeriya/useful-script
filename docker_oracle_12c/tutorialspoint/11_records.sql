/*
|	Program: Records
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt RECORD: Data Structure that cna hold data items of different kinds. Records of differnt fields, similar to a row of a database

prompt --> Table-Based RECORD
prompt --> Cursor-Based Records
prompt --> User-defined records

prompt -------------------------
prompt %ROWTYPE attribute enables a programer to create table-based and Cursorbased records
prompt -------------------------

DECLARE 
	tp_customers_rec tp_customers%ROWTYPE;
BEGIN
	SELECT * INTO 
	tp_customers_rec
	FROM tp_customers
	WHERE id = 5;
	DBMS_OUTPUT.put_line('Customer Id : '|| tp_customers_rec.id);
	DBMS_OUTPUT.put_line('Customer Name : '|| tp_customers_rec.name);
	DBMS_OUTPUT.put_line('Customer Address : '|| tp_customers_rec.address);
	DBMS_OUTPUT.put_line('Customer Salary : '|| tp_customers_rec.salary);
END;
/


prompt ----------------------------

prompt Cursor-based record

prompt ----------------------------

DECLARE
	CURSOR c_tp_customers IS
	SELECT * FROM tp_customers;
	tp_customers_rec c_tp_customers%ROWTYPE;
BEGIN
	OPEN c_tp_customers;
	LOOP
		FETCH c_tp_customers INTO tp_customers_rec;
	
		EXIT WHEN c_tp_customers%NOTFOUND; 
		DBMS_OUTPUT.put_line(tp_customers_rec.id
				||' '
				|| tp_customers_rec.name
				||' '
				|| tp_customers_rec.address
				||' '
				|| tp_customers_rec.salary);
	END LOOP;
END;
/


prompt ----------------------------

prompt User-Define record

prompt ----------------------------

DECLARE
	TYPE books IS RECORD
		( title 	VARCHAr2(50)
		, author 	VARCHar2(50)
		, subject 	VARCHAR2(100)
		, book_id	NUMBER);
	book1 books;
	book2 books;
BEGIN
	-- Boo1 Specification
	book1.title	:= 'C Programming';
	book1.author	:= 'Nuha Ali';
	book1.subject	:= 'C Programming Tutorial';
	book1.book_id	:= 6495407;
	-- Book2 Specification
	book2.title	:= 'Telecom Billing';
	book2.author	:= 'Zara Ali';
	book2.subject	:= 'Telecom Billing Tutorial';
	book2.book_id	:= 6495700;

	-- Print book 1 records
	DBMS_OUTPUT.put_line('Book 1 : ' 
			|| book1.title
			|| ' is written by '
			|| book1.author
			|| '. Book Code is '
			|| book1.book_id 
			|| ' and name is '
			|| book1.subject);
	-- Book2 records
	DBMS_OUTPUT.put_line('Book 2 : ' 
			|| book2.title
			|| ' is written by '
			|| book2.author
			|| '. Book Code is '
			|| book2.book_id 
			|| ' and name is '
			|| book2.subject);
END;
/


prompt --------- RECORDs as Subprogram Parameters

DECLARE
	TYPE books IS RECORD
		( title 	VARCHAR2(50)
		, author	VARCHAR2(50)
		, subject 	VARCHAR2(100)
		, book_id	NUMBER);
	book1 books;

	PROCEDURE printbook ( book books ) 
	IS
	BEGIN
		DBMS_OUTPUT.put_line('Book Information : ' 
			|| book.title
			|| ' is written by '
			|| book.author
			|| '. Book Code is '
			|| book.book_id 
			|| ' and name is '
			|| book.subject);
	END;

BEGIN
	-- book specification
	book1.title	:= 'C Programming';
	book1.author	:= 'Nuha Ali';
	book1.subject	:= 'C Programming Tutorial';
	book1.book_id	:= 6495407;
	
	-- Use procedure to print book details
	printbook(book1);
END;
/
