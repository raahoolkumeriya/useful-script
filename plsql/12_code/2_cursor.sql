/*Enable the SERVEROUTPUT to display block messages*/
SET SERVEROUTPUT ON
/*Start the PL/SQL Block*/
DECLARE
    /*Declare a cursor to select employees data*/
   CURSOR C_EMP IS
      SELECT EMPNO,ENAME
       FROM EMP;
   L_EMPNO EMP.EMPNO%TYPE;
   L_ENAME EMP.ENAME%TYPE;
BEGIN
/*Check if the cursor is already open*/
   IF NOT C_EMP%ISOPEN THEN
     DBMS_OUTPUT.PUT_LINE('***Displaying Employee Info***');
   END IF;
/*Open the cursor and iterate in a loop*/
   OPEN C_EMP;
LOOP
/*Fetch the cursor data into local variables*/
   FETCH C_EMP INTO L_EMPNO, L_ENAME;
   EXIT WHEN C_EMP%NOTFOUND;
/*Display the employee information*/
      DBMS_OUTPUT.PUT_LINE(chr(10)||'Display Information for
employee:'||C_EMP%ROWCOUNT);
      DBMS_OUTPUT.PUT_LINE('Employee Id:'||L_EMPNO);
      DBMS_OUTPUT.PUT_LINE('Employee Name:'||L_ENAME);
END LOOP;
END; /