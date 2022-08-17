
	CREATE TABLE employee_details
		( empno	NUMBER(4)	CONSTRAINT E_PK		PRIMARY KEY
					CONSTRAINT E_EMPNO_CHK 	CHECK ( empno > 7000)
		, enmae VARCHAR2(8)	CONSTRAINT E_NAME_NN	NOT NULL
		, init 	VARCHAR2(5)	CONSTRAINT E_INIT_NN	NOT NULL
		, job	VARCHAR2(8)
		, mgr	NUMBER(4)	CONSTRAINT E_MGR_FK	REFERENCES employee_details
		, bdate DATE		CONSTRAINT E_BDATE_NN	NOT NULL
		, msal	NUMBER(6,2)	CONSTRAINT E_MSAL_NN 	NOT NULL
		, comm	NUMBER(6,2)
		, deptno NUMBER(2)	default 10
		,			CONSTRAINT E_SALES_CHK CHECK (DECODE(job,'SALEREP',0,1) + NVL2(comm,1,0) = 1)
		);

	CREATE TABLE departments
		(department_id		NUMBER(3)	CONSTRAINT D_PK		PRIMARY KEY
						CONSTRAINT D_DEPTNO_CHK	CHECK(MOD(department_id,10) = 0)
		, department_name	VARCHAR2(20)	CONSTRAINT D_DNAME_NN	NOT NULL
						CONSTRAINT D_DNAME_UN	UNIQUE
						CONSTRAINT D_DNAME_CHK	CHECK (department_name = upper(department_name))
		, location_id		NUMBER(10)	CONSTRAINT D_LOC_NN	NOT NULL
		, manager_id		NUMBER(4)	CONSTRAINT D_MGR_FK	REFERENCES employee_details
		);

	ALTER TABLE employee_details ADD 
		( CONSTRAINT E_DPT_FK FOREIGN KEY (deptno) REFERENCES departments);


	create table salgrades
		( grade      NUMBER(2)   constraint S_PK        primary key
		, lowerlimit NUMBER(6,2) constraint S_LOWER_NN  not null
					 constraint S_LOWER_CHK check (lowerlimit >= 0)
		, upperlimit NUMBER(6,2) constraint S_UPPER_NN  not null
		, bonus      NUMBER(6,2) constraint S_BONUS_NN  not null
		,                        constraint S_LO_UP_CHK check (lowerlimit <= upperlimit)
		);

	create table courses
		( code        VARCHAR2(6)  constraint C_PK       primary key
		, description VARCHAR2(30) constraint C_DESC_NN  not null
		, category    CHAR(3)
		, duration    NUMBER(2)
		,			   constraint C_CODE_CHK check (code = upper(code))
		,			   constraint C_CAT_CHK check
							(category in ('GEN','BLD','DSG'))
		);


	create table offerings
		( course     VARCHAR2(6)  constraint O_COURSE_NN not null
					  constraint O_COURSE_FK references courses
		, begindate  DATE	  constraint O_BEGIN_NN  not null
		, trainer    NUMBER(4) 	  constraint O_TRAIN_FK  references employee_details
		, location   VARCHAR2(8)  
		,		constraint O_PK        primary key (course,begindate)	
		);


	create table registrations
		( attendee    NUMBER(4)   constraint R_ATT_NN    not null
					  constraint R_ATT_FK    references employee_details
		, course      VARCHAR2(6) constraint R_COURSE_NN not null
		, begindate   DATE	  constraint R_BEGIN_NN  not null
		, evaluation  NUMBER(1)   constraint R_EVAL_CHK  check (evaluation in (1,2,3,4,5))
		,			  constraint  R_PK primary key
						(attendee,course,begindate)
		,			  constraint  R_OFF_FK foreign key (course,begindate)
							references offerings
		);


	create table history
		( empno      NUMBER(4)	constraint H_EMPNO_NN  not null
					constraint H_EMPNO_FK  references employee_details
								on delete cascade
		, beginyear  NUMBER(4)	constraint H_BYEAR_NN  not null
		, begindate  DATE	constraint H_BDATE_NN  not null
		, enddate    DATE		
		, deptno     NUMBER(2)  constraint H_DEPT_NN not null
					constraint H_DEPT_FK references departments
		, msal       NUMBER(6,2) constraint H_MSAL_NN not null		 		
		, comments   VARCHAR2(60)
		,			constraint H_PK	primary key (empno,begindate)
		,			constraint H_BEG_END check (begindate < enddate)
		);


