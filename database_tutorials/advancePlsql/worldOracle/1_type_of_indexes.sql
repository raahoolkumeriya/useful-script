/*
|	Program: Types of Indexes
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   		Types of Indexes		--;
prompt ---------------------------------------------------;
prompt -- 1. B-tree Index: Is default index type is in the form of a Binary tree;
prompt -- 2. Bitmap Index: has a bitmap for each distinct value indexed, and each bit position represents a row that may or may not contain indexed values. This is best for low-cardinality columns.;

prompt ---------------------------------------------------;
prompt --		INDEX Options			--;
prompt ---------------------------------------------------;
prompt o A unique Index ensure that every indexed value is unique;
prompt o An index can have its key values stored in ascending or descending order;
prompt o A reverse key index index has its key value bytes stored in reverse order;
prompt o A composite index is one that is based on more than one column;
prompt o A function-based index is an index based on a function's return value;
prompt o A compressed insex has repeated key values removed.;
prompt ---------------------------------------------------;

-- select * from tab;

select * from EMPLOYEES_BK;

prompt ---------------------------------------------------;
prompt -- For Unique Index create Primary key on table	--;
prompt ---------------------------------------------------;

SELECT index_name, index_type,uniqueness
FROM USER_INDEXES
WHERE lower(table_name) = 'employees_bk';

ALTER TABLE employees_bk 
	ADD CONSTRAINT pk_emp_bk PRIMARY KEY(employee_id);

prompt ------ Check index ---------------;

SELECT index_name, index_type,uniqueness
FROM USER_INDEXES
WHERE lower(table_name) = 'employees_bk';
