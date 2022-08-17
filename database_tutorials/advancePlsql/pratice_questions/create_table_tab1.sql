/*
CREATE TABLE tab1(
	s_no NUMBER,
	col1	VARCHAR2(1),
	col2	VARCHAR2(1),
	col3	VARCHAR2(1),
	col4	VARCHAR2(1),
	col5	VARCHAR2(1)
);


INSERT INTO tab1 VALUES(1,'A','B','C','D','E');
INSERT INTO tab1 VALUES(2,NULL,'A','B','C','D');
INSERT INTO tab1 VALUES(3,'E',NULL,NULL,NULL,'A');
INSERT INTO tab1 VALUES(4,NULL,'A','E',NULL,'D');
INSERT INTO tab1 VALUES(5,'E','D','C','E',NULL);

SELECT *
FROM TAb1;

*/

CREATE TABLE tab2 (
	col2  VARCHAR2(2));
CREATE TABLE tab3 (
	col3	VARCHAR2(2));

INSERT INTO tab2 values ('A');
INSERT INTO tab2 values ('B');
INSERT INTO tab2 values ('C');
INSERT INTO tab2 values ('D');
INSERT INTO tab2 values ('E');
INSERT INTO tab3 values ('A');
INSERT INTO tab3 values ('C');
INSERT INTO tab3 values ('E');
INSERT INTO tab3 values ('G');

commit;

select * from tab2;
select * from tab3;

