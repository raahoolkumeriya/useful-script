prompt >>>>  System reference Cursors <<<<<
prompt >>> 	- are Pointer to result sets in query work area. A query work area is a memory region ( k/as Context Area) in PGA ( process global area)
prompt 	- You use reference cursors when you want to query data in one program and process it in another
prompt 	- 	Stronlgy typed(has return) and Weakly typed

VARIABLE refcur REFCURSOR;

DECLARE
	TYPE weakly_typed IS REF CURSOR;
	quick WEAKLY_TYPED;
BEGIN
	OPEN quick FOR 
		SELECT table_name, COUNT(*)
		FROM all_tables
		WHERE table_name LIKE '%MAP'
		HAVING ( COUNT(*) > 2 )
		GROUP BY table_name;
	:refcur := quick;
END;
/

SELECT :refcur FROM dual;
