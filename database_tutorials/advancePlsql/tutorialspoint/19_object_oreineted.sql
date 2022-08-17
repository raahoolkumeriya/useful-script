/*
|	Program: Object Oriented
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt -- Simple object consisting of few attributes

CREATE OR REPLACE TYPE address AS OBJECT 
	( house_no	VARCHAR2(10)
	, street	VARCHAR2(30)
	, city		VARCHAR2(20)
	, state		VARCHAR2(10)
	, pincode 	VARCHAR2(10));
/


prompt -- Object will wrap attributes and methods together

CREATE OR REPLACE TYPE customer AS OBJECT
	( code 		NUMBER(5)
	, name		VARCHAR2(30)
	, contact_no	VARCHAR2(12)
	, addr		address         
	, MEMBER PROCEDURE display);
/


