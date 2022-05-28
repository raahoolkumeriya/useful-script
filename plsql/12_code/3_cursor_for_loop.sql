/*Enable the SERVEROUTPUT parameter to print the results in the
environment*/
SET SERVEROUTPUT ON
/*Start the PL/SQL block*/
DECLARE
/*Declare an explicit cursor to select employee information*/
   CURSOR CUR_EMP IS
      SELECT ename, sal
      FROM emp;
BEGIN
/*FOR Loop uses the cursor CUR_EMP directly*/
   FOR EMP IN CUR_EMP
   LOOP
/*Display message*/
   DBMS_OUTPUT.PUT_LINE(EMP.ename||' earns '||EMP.sal||' per month');
   END LOOP;
END;
/