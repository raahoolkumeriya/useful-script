/*
|	Program: Create table Books 
|	Author: Raahool Kumeriya
|	Change history:
|		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		CREATE TABLE books		--;
prompt ---------------------------------------------------;
/*
CREATE TABLE books (
	book_id		INTEGER,
	isbn		VARCHAR2(13),
	title		VARCHAR2(200),
	summary		VARCHAR2(2000),
	author		VARCHAR2(200),
	date_published	DATE,
	page_count	NUMBER
);
*/
INSERT INTO books
            VALUES (1,'1-56592-335-9',
               'Oracle PL/SQL Programming',
               'Reference for PL/SQL developers,' ||
               'including examples and best practice ' ||
               'recommendations.',
               'Feuerstein,Steven, with Bill Pribyl',
               TO_DATE ('01-SEP-1997','DD-MON-YYYY'),
		987);

INSERT INTO books
            VALUES (2,'0-596-00381-1',
               'Oracle PL/SQL Programming, Third Ed.',
               'Reference for PL/SQL developers,' ||
               'including examples and best practice ' ||
               'recommendations. Third Edition',
               'Feuerstein,Steven, with Bill Pribyl',
               TO_DATE ('01-DEC-2000','DD-MON-YYYY'),
                1001);

INSERT INTO books
            VALUES (3,'0-596-00180-0',
               'Learning Oracle PL/SQL',
               'Basic PL/SQL developers,' ||
               'including examples and best practice ' ||
               'recommendations.',
               'Bill Pribyl with Steven Feuerstein',
               TO_DATE ('24-JAN-2003','DD-MON-YYYY'),
                567);

INSERT INTO books
            VALUES (4, '0-596-00680-2',
               'Oracle PL/SQL Language Pocket Reference, Third Ed.',
               'Quick PL/SQL developers,' ||
               'including examples and best practice ' ||
               'recommendations.',
               'Bill Pribyl,Steven Feuerstein, Chip Dawas',
               TO_DATE ('10-AUG-2007','DD-MON-YYYY'),
                1382);


commit;

SELECT * FROM books;

