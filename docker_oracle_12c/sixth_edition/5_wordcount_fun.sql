SET ECHO ON;
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION wordcount ( str IN VARCHAR2)
	RETURN PLS_INTEGER
AS
	/* words PLS_INTEGER := 0; -- **Commented out for intentional errors *** */
	len PLS_INTEGER := NVL(LENGTH(str),0);
	inside_a_word BOOLEAN;
BEGIN
	FOR i IN 1..len + 1 
	LOOP
		IF ASCII(SUBSTR(str, i, 1)) < 33 OR i > len 
		THEN
			IF inside_a_word 
			THEN
				words := words + 1;
				inside_a_word := FALSE;
			END IF;
		ELSE
			inside_a_word := TRUE;
		END IF;
	END LOOP;
	RETURN words;
END;
/

-- sho ERR
show ERRORS FUNCTION wordcount;


CREATE OR REPLACE FUNCTION wordcount ( str IN VARCHAR2)
        RETURN PLS_INTEGER
AS
        words PLS_INTEGER := 0; -- **Commented out for intentional errors *** */
        len PLS_INTEGER := NVL(LENGTH(str),0);
        inside_a_word BOOLEAN;
BEGIN
        FOR i IN 1..len + 1
        LOOP
                IF ASCII(SUBSTR(str, i, 1)) < 33 OR i > len
                THEN
                        IF inside_a_word
                        THEN
                                words := words + 1;
                                inside_a_word := FALSE;
                        END IF;
                ELSE
                        inside_a_word := TRUE;
                END IF;
        END LOOP;
        RETURN words;
END;
/

BEGIN
       DBMS_OUTPUT.PUT_LINE('There are ' || wordcount(CHR(9)) || ' words in a tab');
END; 
/


SELECT table_name, grantee, privilege
FROM USER_TAB_PRIVS_MADE
WHERE table_name = 'WORDCOUNT';
