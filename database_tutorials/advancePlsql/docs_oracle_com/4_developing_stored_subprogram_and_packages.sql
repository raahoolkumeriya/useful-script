/*
|	Program: Developing Stored Subprograms and Packages
|	Author: Raahool Kumeriya
|	Change history:
|		09-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt ---------------------------------;
prompt Creating a standalone Procedure ;
prompt ---------------------------------;

CREATE OR REPLACE PROCEDURE add_evaluation 
	(	evaluation_id 	IN 	NUMBER
	,	employee_id	IN	NUMBER
	,	evaluation_date	IN	DATE
	,	job_id		IN	VARCHAR2
	,	manager_id	IN	NUMBER
	,	department_id	IN	NUMBER
	,	total_score	IN	NUMBER ) AS
BEGIN
	NULL;
END add_evaluation;
/


CREATE OR REPLACE PROCEDURE add_evaluation
        (       evaluation_id   IN      NUMBER
        ,       employee_id     IN      NUMBER
        ,       evaluation_date IN      DATE
        ,       job_id          IN      VARCHAR2
        ,       manager_id      IN      NUMBER
        ,       department_id   IN      NUMBER
        ,       total_score     IN      NUMBER ) AS
BEGIN
	INSERT INTO evaluations (
		evaluation_id, employee_id, evaluation_date, job_id, manager_id, department_id, total_score)
	VALUES ( 
		add_evaluation.evaluation_id,
		add_evaluation.employee_id,
		add_evaluation.evaluation_date,
		add_evaluation.job_id,
		add_evaluation.manager_id,
		add_evaluation.department_id,
		add_evaluation.total_score
	);
END add_evaluation;
/

prompt -----------------------------------------------;
prompt Creating Standalone Functions;
prompt -----------------------------------------------;

CREATE OR REPLACE FUNCTION calculate_score
( 
	cat 	IN VARCHAR2
,	score	IN NUMBER
,	weight 	IN NUMBER
)
	RETURN NUMBER IS
BEGIN
	RETURN	score * weight; 
END calculate_score;
/

prompt -----------------------------------------------;
prompt Testing Standalone Function;
prompt -----------------------------------------------;

Select calculate_score( cat => 'CAT', score => 24, weight => 10)
FROM DUAL;

prompt -----------------------------------------------;
prompt Creating and Managing Package
prompt -----------------------------------------------;

-- pacakge specifiaction
CREATE OR REPLACE PACKAGE emp_eval AS

	PROCEDURE eval_department ( dept_id IN NUMBER);

	FUNCTION calculate_score ( evalaution_id IN NUMBER, performance_id IN NUMBER) RETURN NUMBER;

END emp_eval;
/

-- package body

CREATE OR REPLACE PACKAGE BODY emp_eval AS

	PROCEDURE eval_department ( dept_id IN NUMBER)
	AS
	BEGIN
		NULL;
	END eval_department;

	FUNCTION calculate_score ( evalaution_id IN scores.evaluation_id%TYPE, 
				   performance_id IN scores.performance_id%TYPE) 
	RETURN NUMBER
	AS
		n_score		scores.score%TYPE;
		n_weight	PERFORMANCE_PARTS.WEIGHT%TYPE;
		running_total	NUMBER := 0;
		max_score	CONSTANT scores.score%TYPE := 9;
		max_weigth	CONSTANT PERFORMANCE_PARTS.WEIGHT%TYPE := 1;
	BEGIN
		running_total := max_score * max_weigth;
		RETURN running_total;
	END calculate_score;
END emp_eval;
/


show errors;
