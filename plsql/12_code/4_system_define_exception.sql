/*Enable the SERVEROUTPUT parameter to print the results in the
environment*/
SET SERVEROUTPUT ON
/*Start the PL/SQL block*/
DECLARE
   /*Declare the local variables*/
   L_ENAME VARCHAR2 (100);
   L_SAL NUMBER;
   L_EMPID NUMBER := 8376;
BEGIN
   /*SELECT statement to fetch the name and salary details of the
employee*/
   SELECT ENAME, SAL
   INTO L_ENAME, L_SAL
   FROM EMP
WHERE EMPNO = L_EMPID;
EXCEPTION
   /*Exception Handler */
   WHEN NO_DATA_FOUND THEN
   /*Display an informative message*/
   DBMS_OUTPUT.PUT_LINE ('No Employee exists with the id '||L_EMPID);
END; 
/

/*
The following table lists some of the commonly used system-defined exceptions along with their short name and ORA error code:
Error Named exception Comments (raised when:)

ORA-00001   DUP_VAL_ON_INDEX            Duplicate value exists
ORA-01001   INVALID_CURSOR              Cursor is invalid
ORA-01012   NOT_LOGGED_ON               User is not logged in
ORA-01017   LOGIN_DENIED                System error occurred
ORA-01403   NO_DATA_FOUND               The query returns no data
ORA-01422   TOO_MANY_ROWS               A single row query returns multiple rows
ORA-01476   ZERO_DIVIDE                 An attempt was made to divide a number by zero
ORA-01722   INVALID_NUMBER              The number is invalid
ORA-06504   ROWTYPE_MISMATCH            Mismatch occurred in row type
ORA-06511   CURSOR_ALREADY_OPEN         Cursor is already open
ORA-06531   COLLECTION_IS_NULL          Working with NULL collection
ORA-06532   SUBSCRIPT_OUTSIDE_LIMIT     Collection index out of range
ORA-06533   SUBSCRIPT_BEYOND_COUNT      Collection index out of count
*/