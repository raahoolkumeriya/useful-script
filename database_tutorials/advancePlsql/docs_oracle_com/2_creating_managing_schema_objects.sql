/*
|	Program: Creating and Managing Schema objects
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

CREATE TABLE EVALUATIONS (
  EVALUATION_ID    NUMBER(8,0), 
  EMPLOYEE_ID      NUMBER(6,0), 
  EVALUATION_DATE  DATE, 
  JOB_ID           VARCHAR2(10), 
  MANAGER_ID       NUMBER(6,0), 
  DEPARTMENT_ID    NUMBER(4,0),
  TOTAL_SCORE      NUMBER(3,0)
);


CREATE TABLE SCORES (
  EVALUATION_ID   NUMBER(8,0), 
  PERFORMANCE_ID  VARCHAR2(2), 
  SCORE           NUMBER(1,0)
);


-------------------------------------------------
prompt Crate primary key
-------------------------------------------------
ALTER TABLE EVALUATIONS
	ADD CONSTRAINT EVAL_EVAL_ID_PK PRIMARY KEY (EVALUATION_ID);


-------------------------------------------------
prompt create foreign key
-------------------------------------------------
ALTER TABLE EVALUATIONS
	ADD CONSTRAINT EVAL_EMP_ID_FK FOREIGN KEY (EMPLOYEE_ID)
	REFERENCES EMPLOYEES (EMPLOYEE_ID);

-------------------------------------------------
prompt adding indeces
-------------------------------------------------

CREATE INDEX EVAL_JOB_IX
ON EVALUATIONS (JOB_ID ASC) NOPARALLEL;
