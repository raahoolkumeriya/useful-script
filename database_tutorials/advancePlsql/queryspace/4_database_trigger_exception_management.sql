prompt Database Trigger Exception Mangement
prompt ------------------------------------

prompt -- Database Triggers are Event-driven programs. Trigger are activated when a transactional program unit calls a database object, like a table or view.
prompt -- Database Trigger may sometimes call otehr strored Functions, procedures and packages. When trigger call other objects, those programs units CANNOT contians any transaction control language TCL commands like SAVEPOINT, ROLLBACK or COMMIT.
prompt -- Critical and NON-Critical exception in Databse triggers

prompt ------ Critical Error Database Triggers ------
prompt -- Any transaction that harm the data is a Critical error and must be stoped before it complete.


SET SERVEROUTPUT ON;

DECLARE
	table_exists 	NUMBER(10);
	qry 		VARCHAR2(2000);
	table_does_not_exists EXCEPTION;
BEGIN
	qry := 'select count(table_name) from user_tables where lower(table_name) like ''nc_error''';
	EXECUTE IMMEDIATE qry INTO table_exists;
	IF table_exists = 0 THEN
		EXECUTE IMMEDIATE 
			'CREATE TABLE nc_error
				( error_id		NUMBER		CONSTRAINT pk_nce PRIMARY KEY
				, module_name		VARCHAR2(30)	CONSTRAINT nn_nce_1 NOT NULL
				, table_name 		VARCHAR2(30)
				, class_name		VARCHAR2(30)
				, error_code		VARCHAR2(9)
				, sqlerror_message	VARCHAR2(2000)
				, user_error_message	VARCHAR2(2000)
				, last_update_date	DATE		CONSTRAINT nn_nce_2 NOT NULL
				, last_updated_by	NUMBER		CONSTRAINT nn_nce_3 NOT NULL
				, creation_date		DATE		CONSTRAINT nn_nce_4 NOT NULL
				, created_by		NUMBER		CONSTRAINT nn_nce_5 NOT NULL)';
		EXECUTE IMMEDIATE 'CREATE SEQUENCE nc_error_s1';
		dbms_output.put_line('Table nc_error created!');
	ELSE
		dbms_output.put_line('Table nc_error already exists!');
	END IF;
END;
/

-- create procedure

CREATE OR REPLACE PROCEDURE records_errors
	( module_name 		IN	VARCHAR2
	, table_name		IN	VARCHAR2 := NULL
	, class_name		IN	VARCHAR2 := NULL
	, sqlerror_code		IN	VARCHAR2 := NULL
	, sqlerror_message	IN	VARCHAR2 := NULL
	, user_error_message	IN	VARCHAR2 := NULL ) IS

	-- declare anchore record variable
	nc_error_record  NC_ERROR%ROWTYPE;
	
   BEGIN
	-- substitute actual parameters for default values
	IF module_name IS NOT NULL THEN
		nc_error_record.module_name := module_name;
	END IF;
	IF table_name IS NOT NULL THEN
                nc_error_record.table_name := module_name;
        END IF;
	IF sqlerror_code IS NOT NULL THEN
                nc_error_record.sqlerror_code := sqlerror_code;
        END IF;
	IF sqlerror_message IS NOT NULL THEN
                nc_error_record.sqlerror_message := sqlerror_message;
        END IF;
	IF user_error_message IS NOT NULL THEN
                nc_error_record.user_error_message := user_error_message;
        END IF;

	-- Insert non-critical error records
	INSERT INTO nc_error
	VALUES
	( nc_error_s1.nextval
	, nc_error_record.module_name
	, nc_error_record.table_name
	, nc_error_record.class_name
	, nc_error_record.sqlerror_code
	, nc_error_record.sqlerror_message
	, nc_error_record.user_error_message
	, 2
	, SYSDATE
	, 2
	, SYSDATE);
  EXCEPTION
	WHEN others THEN
		RETURN;
END;
/


-- Create trigger 
CREATE OR REPLACE TRIGGER contact_t2 
BEFORE INSERT ON contact
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
   CURSOR c ( member_id_in NUMBER ) IS
      SELECT null
	FROM contact c
	,    member m
	WHERE c.member_id = m.member_id
	AND c.member_id = member_id_in
	HAVING COUNT(*) > 1;
BEGIN
	FOR i IN c (:new.member_id) LOOP
		record_errors( module_name => 'CREATE_CONTACT_T2'
				, table_name => 'MEMBER'
				, class_name => 'MEMBER_ID ['||:new.contact_id||']'
				, sqlerror_code => 'ORA-20001'
				, user_error_message => 'Too many contacts per account.');
	END LOOP;
	COMMIT;
	RAISE_APPLICATION_ERROR(-20001,'Already two signers.');
END;
/


INSERT INTO contact
VALUES
	( contact_s1.nextval
	, 1002
	,(SELECT   common_lookup_id
		  FROM     common_lookup
		  WHERE    common_lookup_table = 'CONTACT'
		  AND      common_lookup_column = 'CONTACT_TYPE'
		  AND      common_lookup_type = 'CUSTOMER')
	,'Sweeney','Irving','M'
	, 2, SYSDATE, 2, SYSDATE);



COL module_name FORMAT A17
COL user_error_message FORMAT A30

SELECT   error_id
,        module_name
,        user_error_message
FROM     nc_error;


