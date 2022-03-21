-----------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------
-- RETURN SCALAR CALUES OR RESULT SETS
-- CAN ACCEPT PARAMTERS
-- MUST RETURN SOMETHING
-- CAN RETURN REF CURSORS
-----------------------------------------------------------

-- CREATE FUNCTION THAT DOUBLES A GIVE NUMBER
CREATE OR REPLACE FUNCTION double_number ( p_number NUMBER)
    RETURN NUMBER IS 
BEGIN
    RETURN (p_number * 2);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE(double_number(10));
END;
/


-- FUNCTION WITHOUT RETURN STATEMENT
-- FUNCTION MUST RETURN SOMETHING
CREATE OR REPLACE FUNCTION no_return
    RETURN NUMBER IS
BEGIN
    NULL;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(no_return);
END;
/


CREATE OR REPLACE TYPE v_number_t AS TABLE OF NUMBER;
/

-- RETURN A PLSQL TABLE
CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
RETURN v_number_t AS
    v_ret_val v_number_t := v_number_t();
BEGIN
    v_ret_val.EXTEND(p_id);
    FOR counter IN 1..p_id LOOP
        v_ret_val(counter) := counter;
    END LOOP;
    RETURN(v_ret_val);
END;
/


DECLARE 
    v_t v_number_t := v_number_t();
BEGIN
    v_t := return_table(3);
    FOR counter IN 1..v_t.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_t(counter));
    END LOOP;
END;
/


-- DECALRE FUNCTION AS DETERMINICTIC
CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
    RETURN v_number_t
    DETERMINISTIC AS
    v_ret_val v_number_t := v_number_t();
BEGIN
    v_ret_val.EXTEND(p_id);
    FOR counter IN 1..p_id LOOP
        v_ret_val(counter) := counter;
    END LOOP;
    RETURN(v_ret_val);
END;
/

-- FUNCTION THE RETURN REF CIRSOR
CREATE OR REPLACE FUNCTION return_cursor
    RETURN SYS_REFCURSOR IS
    v_curs SYS_REFCURSOR;
BEGIN
    OPEN v_curs FOR 'SELECT * FROM ANIMAL';
    RETURN (v_curs);
END;
/

DECLARE 
    v_curs SYS_REFCURSOR;
    v_animal animal%ROWTYPE;
BEGIN
    v_curs := return_cursor;
    LOOP 
        FETCH v_curs INTO v_animal;
        EXIT WHEN v_curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_animal.animal_name);
    END LOOP;
END;
/


-------------------------------------------------------------
-- RESULT CACHE FUNCTION
-------------------------------------------------------------
-- FUNCTION RESUTLS KEPT IN CACHE
-- USED FOR FAST RETREIVAL BY SUBSEQUNT SESSION
-- INVALIDATED WHEN DML OCCURS ON UNDERLYING BD OBJECTS
-------------------------------------------------------------

SELECT * FROM ANIMAL;
INSERT INTO ANIMAL VALUES(2,'Panda');
COMMIT;

CREATE OR REPLACE FUNCTION counT_animals 
    RETURN NUMBER
    RESULT_CACHE IS
    v_ret_val NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_ret_val
    FROM ANIMAL;
    RETURN(v_ret_val);
END;
/


BEGIN 
    DBMS_OUTPUT.PUT_LINE(counT_animals);
END;
/

SELECT * FROM v$result_cache_objects ;

SELECT NAME,TYPE,INVALIDATIONS
    FROM v$result_cache_objects
    WHERE NAME LIKE '%ANIMAL%';
    
SELECT NAME,VALUE
    FROM v$result_cache_statistics
    WHERE NAME = 'Find Count';

INSERT INTO ANIMAL
VALUES(3,'Tiger');
COMMIT;


--------------------------------------------------------------
-- TABLE FUNCTION
--------------------------------------------------------------
-- FUNCTION RETURN ROWS OF DATA IN A PLSQL  TABLE
-- JSUT LIKE A QUERY ON A DB TABLE WOULD SO
-- THE FUNCTION CAN BE QUERIED JUST LIKE A TABLE
--------------------------------------------------------------


CREATE OR REPLACE TYPE v_number_t AS TABLE OF NUMBER;
/

-- RETURN A PLSQL TABLE
CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
RETURN v_number_t AS
    v_ret_val v_number_t := v_number_t();
BEGIN
    v_ret_val.EXTEND(p_id);
    FOR counter IN 1..p_id LOOP
        v_ret_val(counter) := counter;
    END LOOP;
    RETURN(v_ret_val);
END;
/



-- QUERY THE FUNCTIN AS IF IT WAS A TABLE
SELECT * FROM TABLE(return_table(5))
    WHERE COLUMN_VALUE = 3;
    
SELECT *
    FROM TABLE(return_table(5)) A,
         TABLE(return_table(3)) B
    WHERE A.column_value = B.column_value;
    

-- CREATE OBJECT AND TABEL WITH 2 COLUMNS
CREATE OR REPLACE TYPE v_number_o AS OBJECT (positive_number NUMBER,
                                            negative_number NUMBER);
/

CREATE OR REPLACE TYPE v_number_t AS TABLE OF v_number_o;
/

-- CREATE FUNCTION TO MANUFACTIRE PAIRS OF NUMBER
CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
RETURN v_number_t AS
    v_ret_val v_number_t := v_number_t();
BEGIN
    v_ret_val.EXTEND(p_id);
    FOR counter IN 1..p_id LOOP
        
        v_ret_val(counter) := v_number_o(counter,counter*-1);
    END LOOP;
    RETURN(v_ret_val);
END;
/


-- QUERY THE FUNCTIN AS IT IFT WERE A TABLE
SELECT * FROM
    TABLE(return_table(5))
WHERE positive_number = 3;



-- CREATE OBJECT AND EXISTIGNG TABLES
CREATE OR REPLACE TYPE animal_o AS OBJECT (animal_id  NUMBER,
                                             animal_name VARCHAR2(30),
                                             ascii_animal VARCHAR2(100));
/

CREATE OR REPLACE TYPE animal_t AS TABLE OF animal_o;
/

-- INSTRACTION WITH TABLE
CREATE OR REPLACE FUNCTION ascii_animal (p_id NUMBER)
            RETURN animal_t AS
    v_ret_val animal_t := animal_t();
    v_ascii VARCHAR2(100);
BEGIN
    FOR v_animal IN ( SELECT * FROM ANIMAL) LOOP
        FOR counter IN 1..LENGTH(v_animal.animal_name) LOOP
            v_ascii := v_ascii || ASCII(SUBSTR(v_animal.animal_name,counter,1));
        END LOOP;
    v_ret_val.EXTEND;
    v_ret_val(v_ret_val.LAST) :=animal_o(v_animal.animal_id,
                                        v_animal.animal_name,
                                        v_ascii);
    END LOOP;
    RETURN(v_ret_val);
END;
/



SELECT * FROM TABLE(ascii_animal(2));


--------- --
-- CALL A FUNCTION WITH NO RETURN
CREATE OR REPLACE FUNCTION no_return 
        RETURN v_number_t  AS
BEGIN
    NULL;
END;
/


SELECT * FROM TABLE(no_return);


-- RAISE NO DATA FOND
CREATE OR REPLACE FUNCTION raise_ndf 
        RETURN v_number_t  AS
BEGIN
    RAISE NO_dATA_FOUND;
END;
/


SELECT * FROM TABLE(raise_ndf);



-- RAISE TOO MANY ROWS
CREATE OR REPLACE FUNCTION raise_too_many
        RETURN v_number_t  AS
BEGIN
    RAISE TOO_MANY_ROWS;
END;
/


SELECT * FROM TABLE(raise_too_many);


-------------------------------------------------------------------
-- PIPELINE FUNCTIONS
------------------------------------------------------------------
-- RETURN SUBSETS OF RESULT AS THEY ARE ASSEMBLES
-- NO_DATA_NEEDED EXCEPTION
------------------------------------------------------------------

CREATE OR REPLACE TYPE v_number_t AS TABLE OF NUMBER;
/

-- RETURN A PLSQL TABLE
CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
            RETURN v_number_t
            PIPELINED AS
BEGIN
    FOR counter IN 1..p_id LOOP 
        PIPE ROW(counter);
    END LOOP;
    RETURN;
END;
/

SELECT * FROM TABLE(return_table(9));



CREATE OR REPLACE FUNCTION return_table (p_id NUMBER)
            RETURN v_number_t
            PIPELINED AS
BEGIN
    FOR counter IN 1..p_id LOOP 
        PIPE ROW(counter);
    END LOOP;
    RETURN;
EXCEPTION
    WHEN NO_DATA_NEEDED THEN
        DBMS_OUTPUT.PUT_LINE('In No Data NeeDED');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('In WHEN OTHERS');
END;
/


SELECT * FROM TABLE(return_table(9))
WHERE ROWNUM <= 3;


------------------------------------------------------------
-- PARALLEL TABLE FUNCTIONS
------------------------------------------------------------
-- WORK I SSPREAD ACROSS PARALLEL QUERY SERVICES
    -- RANDOM
    -- RANGE
    -- HASH
-- ORDERED WITHIN EACH PARALLEL QUERY SERVICES
    -- CLUSTERED
    -- ORDERED
------------------------------------------------------------

CREATE TABLE bunch_of_numbers (COL1 NUMBER UNIQUE);

BEGIN
    FOR counter IN 1..10 LOOP
        INSERT INTO bunch_of_numbers
        VALUES(counter);
    END LOOP;
END;
/

SELECT * FROM bunch_of_numbers;

CREATE OR REPLACE TYPE v_number_t AS TABLE OF NUMBER;
/


-- RETURN A PLSQL TABLE
CREATE OR REPLACE FUNCTION return_table (p_curs SYS_REFCURSOR)
                        RETURN v_number_t
                        PIPELINED
                        PARALLEL_ENABLE (PARTITION p_curs BY ANY) AS
    v_number NUMBER;
BEGIN
    LOOP
    FETCH p_curs INTO v_number;
        EXIT WHEN p_curs%NOTFOUND;
        PIPE ROW(v_number);
    END LOOP;
END;
/


SELECT * FROM TABLE(return_table(CURSOR(SELECT * FROM bunch_of_numbers)));



-- FOR BUSNIESS LOGIC YOU WANT DATA 

--CREATE OR REPLACE FUNCTION return_table (p_curs SYS_REFCURSOR)
CREATE OR REPLACE FUNCTION return_table (p_curs cursors.number_cursor)
                        RETURN v_number_t
                        PIPELINED
                    --    PARALLEL_ENABLE (PARTITION p_curs BY RANGE(col1))
                        PARALLEL_ENABLE (PARTITION p_curs BY HASH(col1)) 
                        CLUSTER p_curs BY (col1) AS
                    --    ORDER p_curs BY (COL1) AS
    v_number NUMBER;
BEGIN
    LOOP
    FETCH p_curs INTO v_number;
        EXIT WHEN p_curs%NOTFOUND;
        PIPE ROW(v_number);
    END LOOP;
END;
/

-- TO ELIMINATE THE Error(10,24): PLS-00627: 'P_CURS' must be a strongly typed ref cursor
-- EASILIEST WATY TO CREATE THAT  PACAKGE WITH 

CREATE OR REPLaCE PACKAGE cursors AS
    TYPE number_cursor IS REF CURSOR RETURN bunch_of_numbers%ROWTYPE;
END;
/


------------------------------------------------------------
-- STREAMING TABLE FUNCTIONS
-----------------------------------------------------------
-- ONE TABLE FUNCTION RESULTS ARE PASS AS A CURSOR
-- ..TO ANOTHER TABEL FUNCTION WHOSE RESULT ARE 
-- .. PASSED TO ANOTHER TABLE FUNCTION WHOSE RESULTS ARE
--  FUNCTIONS CAN BE RUN IN PARALLLEL
-- FUNCIONS CAN BE PIPELINED
------------------------------------------------------------


SELECT * FROM BUNCH_OF_NUMBERS;
DELETE BUNCH_OF_NUMBERS;

BEGIN
    FOR counter IN 65..75 LOOP
        INSERT INTO bunch_of_numbers
        VALUES(counter);
    END LOOP;
END;
/

SELECT * FROM bunch_of_numbers;


CREATE OR REPLACE TYPE v_number_t AS TABLE OF NUMBER;
/

CREATE OR REPLaCE PACKAGE cursors AS
    TYPE number_cursor IS REF CURSOR RETURN bunch_of_numbers%ROWTYPE;
END;
/


CREATE OR REPLACE FUNCTION return_table (p_curs cursors.number_cursor)
                        RETURN v_number_t
                        PIPELINED
                        PARALLEL_ENABLE (PARTITION p_curs BY RANGE(col1)) 
                        ORDER p_curs BY (coL1) AS
    v_number NUMBER;
BEGIN
    LOOP
    FETCH p_curs INTO v_number;
        EXIT WHEN p_curs%NOTFOUND;
        PIPE ROW(v_number);
    END LOOP;
END;
/


SELECT * 
    FROM TABLE(return_table(CURSOR(SELECT *
                                    FROM bunch_of_numbers)));



-- SETUP FOR STREMAING
CREATE OR REPLACE TYPE v_vc2_10_t AS TABLE OF VARCHAR2(10);
/


CREATE OR REPLACE FUNCTION return_char (p_curs cursors.number_cursor)
                        RETURN v_vc2_10_t
                        PIPELINED AS
    v_vc2_10 VARCHAR2(10);
BEGIN
    LOOP
    FETCH p_curs INTO v_vc2_10;
        EXIT WHEN p_curs%NOTFOUND;
        PIPE ROW(CHR(v_vc2_10));
    END LOOP;
END;
/



SELECT * 
    FROM TABLE(return_char(CURSOR(
        SELECT * 
            FROM TABLE(return_table(CURSOR(SELECT *
                                    FROM bunch_of_numbers)))
                            )));
