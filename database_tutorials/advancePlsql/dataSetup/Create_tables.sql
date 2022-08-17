/*
||	Program: https://docs.oracle.com/cd/E18283_01/doc.112/e12152/tut_library.htm#insertedID10 
||	Author: Raahool Kumeriya
||	Change history:
||		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ----------------------------------------------------------------;
prompt -- Script for Creating and Using the Library Tutorial Objects --;
prompt ----------------------------------------------------------------;

/*
-- Clean up from any previous tutorial actions.
DROP TABLE transactions;
DROP TABLE librarybooks;
DROP TABLE patrons;
DROP SEQUENCE patron_id_seq;
DROP SEQUENCE transactions_seq;
DROP TRIGGER transactions_trg;
DROP VIEW patrons_trans_view;
DROP PROCEDURE list_a_rating;
DROP PROCEDURE list_a_rating2;
*/

prompt -----------------------; 
prompt -- Create objects.   --;
prompt -----------------------; 
 
CREATE TABLE librarybooks (
   book_id 		VARCHAR2(20),
   title 		VARCHAR2(50)
      		CONSTRAINT title_not_null NOT NULL,
   author_last_name 	VARCHAR2(30)
      		CONSTRAINT last_name_not_null NOT NULL,
   author_first_name 	VARCHAR2(30),
   rating 		NUMBER,
   		CONSTRAINT librarybooks_pk PRIMARY KEY (book_id),
   		CONSTRAINT rating_1_to_10 CHECK (rating IS NULL OR (rating >= 1 and rating <= 10)),
   		CONSTRAINT author_title_unique UNIQUE (author_last_name, title));
 
CREATE TABLE patrons (
   patron_id	 	NUMBER,
   last_name 		VARCHAR2(30)
      		CONSTRAINT patron_last_not_null NOT NULL,
   first_name 		VARCHAR2(30),
   street_address 	VARCHAR2(50),
   city_state_zip 	VARCHAR2(50),
   location 		MDSYS.SDO_GEOMETRY,
   		CONSTRAINT patrons_pk PRIMARY KEY (patron_id));
 
CREATE TABLE transactions (
   transaction_id 	NUMBER,
   patron_id 	CONSTRAINT for_key_patron_id
      			REFERENCES patrons(patron_id),
   book_id 	CONSTRAINT for_key_book_id
      			REFERENCES librarybooks(book_id),
   transaction_date 	DATE
      		CONSTRAINT tran_date_not_null NOT NULL,
   transaction_type 	NUMBER
      		CONSTRAINT tran_type_not_null NOT NULL,
   		CONSTRAINT transactions_pk PRIMARY KEY (transaction_id));
 
CREATE SEQUENCE patron_id_seq 
   START WITH 100
   INCREMENT BY 1;
 
prompt -----------------------------------------------; 
prompt -- The sequence for the transaction_id 	    --;
prompt -- in the tutorial is created automatically, --;
prompt -- and may have the name TRANSACTIONS_SEQ.   --;
prompt -----------------------------------------------;
 
CREATE SEQUENCE transactions_seq 
   START WITH 1
   INCREMENT BY 1;
 
prompt ---------------------------------------------------------; 
prompt -- The before-insert trigger for transaction ID values --;
prompt -- in the tutorial is created automatically,           --;
prompt -- and may have the name TRANSACTIONS_TRG.	      --;
prompt ---------------------------------------------------------; 
CREATE OR REPLACE TRIGGER transactions_trg
   BEFORE INSERT ON TRANSACTIONS 
  FOR EACH ROW 
  BEGIN
    SELECT TRANSACTIONS_SEQ.NEXTVAL INTO :NEW.TRANSACTION_ID FROM DUAL;
  END;
/
 
CREATE VIEW patrons_trans_view AS
  SELECT p.patron_id,
         p.last_name,
         p.first_name,
         t.transaction_type,
         t.transaction_date
    FROM patrons p, transactions t
   WHERE p.patron_id = t.patron_id
   ORDER BY p.patron_id, t.transaction_type;
 
prompt -------------------------------------------------------------------; 
prompt -- Procedure: List all librarybooks that have a specified rating.--;
prompt -------------------------------------------------------------------; 
CREATE OR REPLACE PROCEDURE list_a_rating(in_rating IN NUMBER) AS
  matching_title VARCHAR2(50);
  TYPE my_cursor IS REF CURSOR;
  the_cursor my_cursor;
BEGIN
  OPEN the_cursor
    FOR 'SELECT title 
           FROM librarybooks 
          WHERE rating = :in_rating'
    USING in_rating;
  DBMS_OUTPUT.PUT_LINE('All librarybooks with a rating of ' || in_rating || ':');
  LOOP
    FETCH the_cursor INTO matching_title;
    EXIT WHEN the_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(matching_title);
  END LOOP;
  CLOSE the_cursor;
END;
/
show errors;
 
prompt -----------------------------; 
prompt -- Insert and query data.  --;
prompt -----------------------------; 

INSERT INTO librarybooks VALUES ('A1111', 'Moby Dick', 'Melville', 'Herman', 10);
INSERT INTO librarybooks VALUES ('A2222', 'Get Rich Really Fast', 'Scammer', 'Ima', 1);
INSERT INTO librarybooks VALUES ('A3333', 'Finding Inner Peace', 'Blissford', 'Serenity', null);
INSERT INTO librarybooks VALUES ('A4444', 'Great Mystery Stories', 'Whodunit', 'Rodney', 5);
INSERT INTO librarybooks VALUES ('A5555', 'Software Wizardry', 'Abugov', 'D.', 10);
 
INSERT INTO patrons VALUES  (patron_id_seq.nextval, 
   'Smith', 'Jane', '123 Main Street', 'Mytown, MA 01234', null);
INSERT INTO patrons VALUES  (patron_id_seq.nextval, 
   'Chen', 'William', '16 S. Maple Road', 'Mytown, MA 01234', null);
INSERT INTO patrons VALUES  (patron_id_seq.nextval, 
   'Fernandez', 'Maria', '502 Harrison Blvd.', 'Sometown, NH 03078', null);
INSERT INTO patrons VALUES  (patron_id_seq.nextval, 
   'Murphy', 'Sam', '57 Main Street', 'Mytown, MA 01234', null);
 
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (100, 'A1111', SYSDATE, 1);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (100, 'A2222', SYSDATE, 2);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (101, 'A3333', SYSDATE, 3);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (101, 'A2222', SYSDATE, 1);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (102, 'A3333', SYSDATE, 1);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (103, 'A4444', SYSDATE, 2);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (100, 'A4444', SYSDATE, 1);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (102, 'A2222', SYSDATE, 2);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (102, 'A5555', SYSDATE, 1);
INSERT INTO transactions (patron_id, book_id, 
  transaction_date, transaction_type) 
  VALUES (101, 'A2222', SYSDATE, 1);
 
commit ;

prompt --------------------------------------; 
prompt -- Test the view and the procedure. --;
prompt --------------------------------------; 
SELECT * FROM patrons_trans_view;
CALL list_a_rating(10);

