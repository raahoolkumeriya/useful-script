prompt Relational Database System and Oracle

COL TABLE_NAME FORMAT A40;
SET PAGESIZE 1000;
SET TIMING ON;

prompt ----- CAT -- Synonym for USER_CATALOG ----  
SELECT * FROM cat;


prompt ------------ Describe ---------
describe ALL_USERS;



prompt ------------ dict_columns ---------

COL column_name FORMAT A20;
COL comments FORMAT A20;

SELECT column_name
,	comments
FROM dict_columns
WHERE table_name = 'ALL_USERS';


prompt ---- NLS_SESSION_PARAMETERS --------

COL PARAMETER FORMAT A30;
COL VALUE FORMAT A30; 
SELECT *
FROM nls_session_parameters;


prompt CAT --- Synonym for USER_CATALOG
prompt COLS --- Synonym for USER_TAB_COLUMNS
prompt DICT ---Synonym for DICTIONARY
prompt DUAL --- Dummy table, with one row and one column 
prompt IND  --- Synonym for USER_INDEXES
prompt OBJ  ---- Synonym for USER_OBJECTS 
prompt SYN  ---- Synonym for USER_SYNONYMS 
prompt TABS ---- Synonym for USER_TABLES


