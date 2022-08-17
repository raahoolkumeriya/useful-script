/*
|	Program: SEQUENCE generator 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		SEQUENCE generator		--;
prompt ---------------------------------------------------;
prompt ---------------------------------------------------;
prompt Sequence Generator ;
prompt - Are nothing but the database object which will generate sequential/searial values;
prompt - 2 Pseudo Columns: ;
prompt - NEXTVAL and CURRVAL;
prompt - Advantage: It help to gnerate PRIMARY Key or serrogate KEY automatically;
prompt -----------: All these serial numbers are fetched form RAM hence it is faster;
prompt -----------: One Sequence generator can be use in N number of tables. it is reusable;
prompt -
prompt ---------------------------------------------------;

prompt -- Syntax:;
prompt CREATE SEQUENCE seq_name
prompt START with 1
prompt increment by 10
prompt maxvalue 500   	-- optional
prompt cycle 		-- optional
prompt cache 20;	-- optional


prompt ---------------------------------------------------;
prompt CREATE sequence ;
prompt ---------------------------------------------------;
CREATE SEQUENCE seq 
start with 1
increment by 2;

prompt ---------------------------------------------------;
prompt Create table and use seq value in insert;
prompt ---------------------------------------------------;

CREATE TABLE tab_seq_test (
	id 	NUMBER,
	name	VARCHAR2(30)
);

INSERT ALL
	INTO tab_seq_test (ID,name) VALUES (seq.NEXTVAL, 'raahool')
	INTO tab_seq_test (ID,name) VALUES (seq.NEXTVAL, 'sanu')
	INTO tab_seq_test (ID,name) VALUES (seq.CURRVAL, 'Akanksha')
SELECT * FROM DUAL;

SELECT * FROM tab_seq_test;

