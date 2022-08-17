/*
|	Program: IDENTITY columns 
|	Author: Raahool Kumeriya
|	Change history:
|		31-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     INDENTITY Columns				--;
prompt ---------------------------------------------------;

/* Create a table for demonstration purpose
CREATE TABLE t_id_col( 
	id	NUMBER GENERATED AS IDENTITY,
	name	VARCHAR2(20)
);

*/

COL identity_column FORMAT A30;
COL column_name FORMAT A30;
COL table_name FORMAT A30;
COL DATA_DEFAULT FORMAT A30;
COL IDENTITY_OPTIONS FORMAT A30;

/*Query identity column information in USER_TAB_COLS*/
SELECT column_name, data_default, user_generated, identity_column
FROM user_tab_cols
WHERE table_name = 'T_ID_COL'
/


/*Check the sequence configuration from USER_TAB_IDENTITY_COLS view*/
SELECT table_name, column_name, generation_type,
REGEXP_SUBSTR(identity_options, '[^,]+', 1, LEVEL) identity_options
FROM user_tab_identity_cols
WHERE table_name = 'T_ID_COL'
CONNECT BY REGEXP_SUBSTR(identity_options,'[^,]+', 1, LEVEL)
IS NOT NULL
/

*Insert test data in the table*/
BEGIN
	 INSERT INTO t_id_col (name) VALUES ('Allen');
	 INSERT INTO t_id_col (name) VALUES ('Matthew');
	 INSERT INTO t_id_col (name) VALUES ('Peter');
COMMIT;
END;
/

/*Query the table*/
SELECT id, name FROM t_id_col
/

INSERT INTO t_id_col VALUES (7,'Steyn');
