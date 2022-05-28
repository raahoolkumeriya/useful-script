prompt >>> BUffer and Outputting to the Condole <<<

SET SERVEROUTPUT ON SIZE 1000000;

-- enable buffer
BEGIN
	dbms_output.disable;
	dbms_output.enable(1000000);
	dbms_output.put('Line ');
	dbms_output.put('One.');
	dbms_output.new_line;
	dbms_output.put_line('Line Two.');
END;
/

prompt >>> Characters and Strings <<<
DECLARE
	c CHAR(32767) := ' ';
	v VARCHAR2(32767) := ' ';
BEGIN
	dbms_output.put_line('c is ['||LENGTH(c)||']');
	dbms_output.put_line('c is ['||LENGTH(v)||']');
	v := v || ' ';
	dbms_output.put_line('c is ['||LENGTH(v)||']');
END;
/

