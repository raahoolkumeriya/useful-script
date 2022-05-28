/*Enable the Serveroutput to display block messages*/
SET SERVEROUTPUT ON

/*Start the PL/SQL block*/
DECLARE
/*Declare a local variable and initialize with a default value*/
   L_STR VARCHAR2(50) := 'Hello PL/SQL';
BEGIN
/*Print the result*/
   DBMS_OUTPUT.PUT_LINE('I Said - '||L_STR);
END;
/