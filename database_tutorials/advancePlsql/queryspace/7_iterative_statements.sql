prompt >>>> ITERATIVE Statements <<<<
prompt ---- Simple Loop statements
SET SERVEROUTPUT ON;

prompt Guard on ENtry 
DECLARE
	counter NUMBER;
	first BOOLEAN;
BEGIN
	LOOP
		-- loop index mangement
		IF NVL(counter,1) >= 1 THEN
			IF NOT NVL(first,TRUE) THEN
				counter := counter + 1;
			ELSE
				counter := 1;
				first := FALSE;
			END IF;
		END IF;
		-- exit mangement
		EXIT WHEN NOT counter < 3;
			dbms_output.put_line('Iteration ['||counter||']');
	END LOOP;
END;
/

prompt Guard on EXIT 

DECLARE
        counter NUMBER;
        first BOOLEAN;
BEGIN
        LOOP
                -- loop index mangement
                IF NVL(counter,1) >= 1 THEN
                        IF NOT NVL(first,TRUE) THEN
                                counter := counter + 1;
                        ELSE
                                counter := 1;
                                first := FALSE;
                        END IF;
                END IF;
                dbms_output.put_line('Iteration ['||counter||']');
                -- exit mangement
                EXIT WHEN NOT counter < 3;
        END LOOP;
END;
/

prompt "Continue statement"

DECLARE
        counter NUMBER;
        first BOOLEAN;
BEGIN
        LOOP
                -- loop index mangement
                IF NVL(counter,1) >= 1 THEN
                        IF NOT NVL(first,TRUE) THEN
                                counter := counter + 1;
                        ELSE
                                counter := 1;
                                first := FALSE;
                        END IF;
                END IF;
                -- exit mangement
                EXIT WHEN NOT counter < 3;
		IF counter = 2 THEN
			CONTINUE;
		ELSE
			dbms_output.put_line('Iteration ['||counter||']');
		END IF;
        END LOOP;
END;
/


prompt >>> FOR Loop <<<<

BEGIN
	FOR i IN 1..3 LOOP
		dbms_output.put_line('Iteration ['||i||']');
	END LOOP;
END;
/

prompt >>> Cursor FOR Loop
BEGIN
	FOR i IN ( SELECT table_name FROM all_tables WHERE table_name LIKE '%MAP' ) LOOP
		dbms_output.put_line('Iteration ['||i.table_name||']');
	END LOOP;
END;
/

prompt >>> While loop statements
DECLARE
	counter NUMBER := 1;
BEGIN
	WHILE ( counter < 3 ) LOOP
		dbms_output.put_line('Index['||counter||']');
		IF counter >= 1 THEN
			counter := counter + 1;
		END IF;
	END LOOP;
END;
/



