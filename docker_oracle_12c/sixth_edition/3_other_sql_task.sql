
SPOOL report.txt
prompt SHOW ALL

prompt 

DEFINE x = 'the answer is 10'

DEFINE x

SELECT '&x' FROM dual;


prompt Bind variable 
VARIABLE x VARCHAR2(10);
BEGIN
	:x := 'hullo';
END;
/

PRINT :x

SELECT :x, '&x' FROM DUAL;


SPOOL OFF
