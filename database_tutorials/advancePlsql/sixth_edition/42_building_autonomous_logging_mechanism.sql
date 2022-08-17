/*
||	Program: Building an Autonomous Logging Mechanism 
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
prompt -- Building an Autonomous Logging Mechanism    	--;
prompt ---------------------------------------------------;
prompt o -------- Log table defined ----------------------;

CREATE TABLE logtab (
	code 		INTEGER,
	text 		VARCHAR2(4000),
	created_on	DATE,
	created_by	VARCHAR2(100),
	changed_on	DATE,
	changed_by	VARCHAR2(100)
);

prompt o -- DOnt insert direct record to log table, instead, we should build a layer of code arround the table ( this is called Encapsulation);

-- Package specfication
CREATE OR REPLACE PACKAGE log
	AUTHID DEFINER 
IS
	/* putline simply perform insert */
	PROCEDURE putline(p_code_in IN INTEGER, p_text_in IN VARCHAR2);
	/* saveline procedure will be autonomous transation routine */
	PROCEDURE saveline(p_code_in IN INTEGER, p_text_in IN VARCHAR2);
END log;
/

SHOW ERRORS;

-- Package BODY
CREATE OR REPLACE PACKAGE BODY log
IS
        /* putline simply perform insert */
        PROCEDURE putline(p_code_in IN INTEGER, p_text_in IN VARCHAR2)
	IS
	BEGIN
		INSERT INTO logtab
			VALUES (
				p_code_in,
				p_text_in,		
				SYSDATE,
				USER,
				SYSDATE,
				USER
			);
	END putline;

	/* saveline procedure will be autonomous transation routine */
	PROCEDURE saveline(p_code_in IN INTEGER, p_text_in IN VARCHAR2)
	IS
		PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
		putline(p_code_in, p_text_in);
		COMMIT;
	EXCEPTION WHEN OTHERS THEN ROLLBACK;
	RAISE;
	END saveline;
END log;
/

SHOW ERROR;

