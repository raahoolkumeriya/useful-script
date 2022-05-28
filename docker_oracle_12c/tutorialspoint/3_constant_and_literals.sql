prompt Constants

prompt Decalring a Constant

SET SERVEROUTPUT ON;

DECLARE
	-- constant declaration
	pi CONSTANT NUMBER := 3.14592654;
	-- other declaration
	radius 	NUMBER(5,2);
	dia	NUMBER(5,2);
	circumference NUMBER(7,2);
	area NUMBER(10,2);
BEGIN
	-- processing 
	radius 	:= 9.5;
	dia	:= radius * 2;
	circumference := 2.0 * pi * radius;
	area	:= pi * radius * radius;
	-- output 
	DBMS_OUTPUT.put_line('Radius : '|| radius);
	DBMS_OUTPUT.put_line('Diameter : '|| dia);
	DBMS_OUTPUT.put_line('Circumference : '|| circumference);
	DBMS_OUTPUT.put_line('Area : '|| area);
END;
/


DECLARE 
   message  varchar2(30):= 'That''s tutorialspoint.com!'; 
BEGIN 
   dbms_output.put_line(message); 
END; 
/  
