prompt Data-types in PLSQL

prompt Category 
prompt --> Scalar ( Single value with no internal component such as NUMBER, DATE or BOOLEAN )
prompt  |-----> Numeric 
prompt  |--------------------------> PLS_INTEGER
prompt  |--------------------------> BINARY_RANGE
prompt  |--------------------------> BINARY_FLOAT
prompt  |--------------------------> BINARY_DOUBLE
prompt  |--------------------------> NUMBER(prec, scale)
prompt  |--------------------------> DEC(prec, scale) 
prompt  |--------------------------> DECIMAL(prec,scale)
prompt  |--------------------------> NUMERIC(prec, scale) 
prompt  |--------------------------> DOUBLE PRECISION
prompt  |--------------------------> FLOAT
prompt  |--------------------------> INT 
prompt  |--------------------------> INTEGER
prompt  |--------------------------> SMALLINT
prompt  |--------------------------> REAL
prompt  |-----> Charater
prompt  |--------------------------> CHAR 
prompt  |--------------------------> VARCHAR2
prompt  |--------------------------> RAW
prompt  |--------------------------> NCHAR
prompt  |--------------------------> NVARCHAR2
prompt  |--------------------------> LONG 
prompt  |--------------------------> LONG RAW
prompt  |--------------------------> ROWID
prompt  |--------------------------> UROWID
prompt  |-----> Boolean
prompt  |--------------------------> BOOLEAN 
prompt  |-----> Datetime
prompt  |--------------------------> DATE


prompt --> large Objects (LOB) : (Pointer to large objects taht are stored seperately from other data items such as text,graphic image, video clips and sound waveforms)
prompt  |-----> BFILE
prompt  |-----> BLOB 
prompt  |-----> CLOB
prompt  |-----> NCLOB

prompt --> Composite : Internal components that can be access indivilly. eg. Collections and records
prompt  |----->

prompt --> Reference: Pointer to other data items
prompt  |----->

prompt PLSQL User-Defined Subtypes
SET SERVEROUTPUT ON;

DECLARE
	SUBTYPE name IS CHAR(20);
	SUBTYPE message IS VARCHAR2(100);
	salutaion name;
	greeting message;
BEGIN
	salutaion := 'Reader';
	greeting := 'Welcome to the world of PLSQL';
	DBMS_OUTPUT.put_line(
		'Hello '
		|| salutaion
		|| ', '
		|| greeting);	
END;
/

