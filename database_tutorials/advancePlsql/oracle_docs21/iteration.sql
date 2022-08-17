/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: About iterations 
|
|	Change history:
|	Date		Who		Description
|	----------	----------	-----------------------------------
|	28-JUN-22  	codelocked	Program Created
|
+ - - - */

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			ALL About Iterations		  ;
prompt ---------------------------------------------------;

BEGIN
  FOR i IN 1..3 LOOP
     DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
END;
/

BEGIN
   FOR n NUMBER(5,1) IN 1.0 .. 3.0 BY 0.5 LOOP
      DBMS_OUTPUT.PUT_LINE(n);
   END LOOP;
END;
/


