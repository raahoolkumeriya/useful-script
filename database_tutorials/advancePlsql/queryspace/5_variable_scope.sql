prompt >>> VARIABLE SCOPE <<<<

SET SERVEROUTPUT ON;

DECLARE
	current_block	VARCHAR2(10)	:= 'Outer';
	outer_block	VARCHAR2(10)	:= 'Outer';
BEGIN
	dbms_output.put_line('[current_block]['||current_block||']');
	DECLARE
		current_block	VARCHAR2(10)	:= 'Inner';
	BEGIN
		dbms_output.put_line('[current_block]['||current_block||']');
		dbms_output.put_line('[outer_block]['||outer_block||']');
	END;
	dbms_output.put_line('[current_block]['||current_block||']');
	
END;
/
	
