------------------------------------------------
------------- DML TRIGGERS
--  FIRE FOR DAA MANIPULATION LANAGUAGE (DML) IN SQL
    -- INSERT
    -- UPDATE
    -- DELETE
-- FIRE PER STATEMENT OR PRE ROW PROCESSED
-- ATTACHED TO  A TABLE
-- OPTIONALLY FIR FOR SPECIFIC COLUMN IN TABLE
-------------------------------------------------------

SELECT * FROM ANIMAL;

CREATE SEQUENCE ANIMAL_SEQ
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
SELECT ANIMAL_SEQ.NEXTVAL FROM DUAL;

-- ROW LEVEL TRIGGER TO MANUFACTURE ANIMAL ID 
-- FROM SEQUENCE BEFORE THE RECORD IS INSERTED
CREATE OR REPLACE TRIGGER before_animal_row
BEFORE INSERT ON ANIMAL
FOR EACH ROW 
BEGIN
    :NEW.animal_id := ANIMAL_SEQ.nextval;
    DBMS_OUTPUT.PUT_LINE('Before Row '|| :NEW.animal_id);
END;
/

INSERT INTO ANIMAL(ANIMAL_NAME)
VALUES ('Tiger');


-- ROW LEVEL TRIGGER AFTER INSERT
CREATE OR REPLACE TRIGGER after_animal_row
AFTER INSERT ON ANIMAL
FOR EACH ROW
BEGIN
    -- IT WILL THROW ERROR FOR AFTER LEVEL TRIGGER BECAUS WE ARE ATTEMPTING TO MODIFY NEW VALUE AFTER INSERT
    --  :NEW.animal_id := ANIMAL_SEQ.nextval;
    DBMS_OUTPUT.PUT_LINE('AFTER ROW  '|| ANIMAL_SEQ.nextval);
END;
/


--CREATE STATEMENT/TABLE LEVEL TERIGGER BEFOR EINSERT
CREATE OR REPLACE TRIGGER before_animal_table
BEFORE INSERT ON ANIMAL
BEGIN
    -- IT WIL FAIL AS AS IT IT STATEMENT LEVEL TIRGGER
    -- :NEW.animal_id := ANIMAL_SEQ.nextval;
    DBMS_OUTPUT.PUT_LINE('BEFORE STATEMENT ');
END;
/


-- CREATE STATEMETN/TABLE LEVEL TRIGGER AFTER INSERT
CREATE OR REPLACE TRIGGER after_animal_table
AFTER INSERT ON ANIMAL
BEGIN
    -- :NEW.animal_id := ANIMAL_SEQ.nextval;
    DBMS_OUTPUT.PUT_LINE('AFTER STATEMENT ');
END;
/

-- BULK INSERT 
DECLARE 
    TYPE v_vc230_t IS TABLE OF VARCHAR2(30);
    v_animal v_vc230_t := v_vc230_t();
BEGIN
    V_ANIMAL.EXTEND(3);
    v_animal(1) := 'Elephant';
    v_animal(2) := 'Hippo';
    v_animal(3) := 'Snake';
    FORALL counter IN 1..3
    INSERT INTO ANIMAL(animal_name)
    VALUES(v_animal(counter));
END;
/    
    
ALTER TRIGGER before_animal_row DISABLE;

INSERT INTO ANIMAL(ANIMAL_NAME) 
VALUES('Albatross');

-- CHECK TRIGGER DEFINATION IN THE DATABASE
SELECT TRIGGER_NAME, TRIGGER_TYPE,
    TRIGGERING_EVENT
FROM USER_TRIGGERS;


--- DROP TRIGGER
DROP TRIGGER before_animal_row;
DROP TRIGGER AFTER_animal_row;
DROP TRIGGER BEFORE_ANIMAL_TABLE;
DROP TRIGGER AFTER_ANIMAL_TABLE;

-- ONE TRIGGER FOR MULTIPLE DML TYPES
CREATE OR REPLACE TRIGGER animal_dml
BEFORE INSERT OR UPDATE OR DELETE ON animal
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Inserting');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Deleting');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Updating');
    ELSE
        DBMS_OUTPUT.PUT_LINE('What are you doing?');
    END IF;
END;
/

SELECT * FROM ANIMAL;
--PERFORM DML
INSERT INTO ANIMAL VALUES(99,'Crocodile');
UPDATE ANIMAL SET ANIMAL_NAME='NotCrocO' WHERE ANIMAL_ID=99;
DELETE ANIMAL WHERE ANIMAL_ID=99;

DROP TRIGGER ANIMAL_DML;


-- TRIGGER TO DISPLAY RECRDS BEING UPDATE OR DELETED
CREATE OR REPLACE TRIGGER animal_dml
BEFORE UPDATE OR DELETE ON ANIMAL 
FOR EACH ROW
BEGIN
    IF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETING ' ||
                        :OLD.animal_id|| ' '||
                        :OLD.animal_name);
    ELSIF UPDATING THEN 
        DBMS_OUTPUT.PUT_LINE('UPDATING ' ||
                        :OLD.animal_id|| ' '||
                        :OLD.animal_name || ' TO '||
                        :NEW.animal_id || ' ' ||
                        :NEW.animal_name);
    END IF;
END;
/


UPDATE ANIMAL SET ANIMAL_NAME='aNIMAL' ||ANIMAL_ID
WHERE MOD(ANIMAL_ID,2) = 0;

DELETE ANIMAL 
WHERE MOD(ANIMAL_ID,2) <> 0;
        
DELETE ANIMAL;

DROP TRIGGER animal_dml;

-- TRIGGER TO PREVENT DELETE OR UPDATES
CREATE OR REPLACE TRIGGER animal_dml
BEFORE UPDATE OR DELETE ON ANIMAL
BEGIN
    IF DELETING THEN
        RAISE_aPPLICATION_ERROR(-20000,'nO DELETED ALLOWED');
    ELSIF UPDATING THEN 
        RAISE_aPPLICATION_ERROR(-20001,'nO UDADATION ALLOWED');
    END IF;
END;
/

Delete animal;

UPDATE ANIMAL SET ANIMAL_NAME = 'bob';

DROP TRIGGER ANIMAL_DML;

-- TRIGGER FIRING FOR SPECIFI COLUMN AND HAVING SPECIFIC 
-- VALUE . ALSO RENAMES OLD AND NEW STRUCTRE
CREATE OR REPLACE TRIGGER BEFORE_UPDATE 
BEFORE UPDATE OF animal_id ON animal
REFERENCING OLD AS old_rec NEW AS new_rec
FOR EACH ROW
WHEN (old_rec.animal_id > 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'Cant Update ID '|| :old_rec.animal_id);
END;
/

ROLLBACK;
SELECT * FROM ANIMAL;

INSERT INTO ANIMAL VALUES(2,'PaNda');
COMMIT;
UPDATE ANIMAL 
SET animal_name = 'MINAL';

UPDATE ANIMAL
SET ANIMAL_ID = ANIMAL_ID
WHERE ANIMAL_ID > 1;


--------------------------------------------------------
-- TRIGGER ODERING 
-------------------------------------------------------
-- MULTIPLE TRIGGER OF EACH TYPE CAN BE CREATED FOR A TABLE
-- ALL OF THE ENABLED ONES WILL FIRE
-- TEH ORDER THEY FIRE IN IS NOT GURAANTED TO BE CONSISTENCE
-- THE FOLLOWS CLAUSE GRANANTEES THE FIRING ORDER
----------------------------------------------------------

SELECT * FROM ANIMAL;

-- CREATE "FIRST" TRIGGER
CREATE OR REPLACE TRIGGER animal_one
BEFORE INSERT ON animal
FOR EACH ROW
BEGIN
    :NEW.ANIMAL_ID := 33;
    DBMS_OUTPUT.PUT_LINE('ONE');
END;
/


-- CREATE "SECOND" TRIGGER
CREATE OR REPLACE TRIGGER animal_two
BEFORE INSERT ON animal
FOR EACH ROW
BEGIN
    IF :NEW.ANIMAL_ID = 33 THEN
        :NEW.animal_id := 66;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Two');
END;
/



-- CREATE "THIRD" TRIGGER
CREATE OR REPLACE TRIGGER animal_three
BEFORE INSERT ON animal
FOR EACH ROW
BEGIN
    IF :NEW.ANIMAL_ID = 66 THEN
        :NEW.animal_id := 99;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Three');
END;
/




INSERT INTO animal
VALUES (0,'Leopard');

SELECT * FROM animal;


ROLLBACK;

-- CREATE "SECOND" TRIGGER WITH FOLLOWS CLAUSE
CREATE OR REPLACE TRIGGER animal_two
BEFORE INSERT ON animal
FOR EACH ROW
FOLLOWS animal_one
BEGIN
    IF :NEW.ANIMAL_ID = 33 THEN
        :NEW.animal_id := 66;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Two');
END;
/




-- CREATE "THIRD" TRIGGER WITH FOLLOWS CLAUSE
CREATE OR REPLACE TRIGGER animal_three
BEFORE INSERT ON animal
FOR EACH ROW
FOLLOWS animal_two
BEGIN
    IF :NEW.ANIMAL_ID = 66 THEN
        :NEW.animal_id := 99;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Three');
END;
/





INSERT INTO animal
VALUES (0,'Leopard');

SELECT * FROM animal;



DROP TRIGGER animal_three;
DROP TRIGGER animal_tWO;
DROP TRIGGER animal_one;


------------------------------------------------------------------
------ - COMPOUND TRIGGERS 
------------------------------------------------------------------
-- ENCAPSULATES ALL BEFORE AND AFTER TRIGGERS IN ONE PLACE
    -- BEFORE AND AFTER STATEMENTS
    -- BEFORE AND AFTER ROW
-- ON A PER TABEL BASIS
-- ALSO ADD VARIABLES
----------------------------------------------------------------

CREATE OR REPLACE TRIGGER compound_animal
FOR INSERT ON ANIMAL
COMPOUND TRIGGER

    BEFORE STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Compound before Statement');
    END BEFORE STATEMENT;
    
    BEFORE EACH ROW IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Compound before Row');
    END BEFORE EACH ROW;

    AFTER EACH ROW IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Compound After ROW ');
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Compound After Statement');
    END AFTER STATEMENT;
    
END;
/

SELECT * FROM ANIMAL;

INSERT INTO ANIMAL
VALUES(89,'FOX');


SELECT OBJECT_TYPE, OBJECT_NAME FROM USER_OBJECTS
WHERE  OBJECT_NAME = 'COMPOUND_ANIMAL';

SELECT TRIGGER_NAME, TRIGGER_TYPE FROM USER_TRIGGERS;



CREATE OR REPLACE TRIGGER compound_animal
FOR INSERT ON ANIMAL
COMPOUND TRIGGER

    v_local_variable NUMBER := 1;
    
    BEFORE STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_local_variable);
        v_local_variable := v_local_variable + 1;
    END BEFORE STATEMENT;
    
    BEFORE EACH ROW IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_local_variable);
        v_local_variable := v_local_variable + 1;
    END BEFORE EACH ROW;

    AFTER EACH ROW IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_local_variable);
        v_local_variable := v_local_variable + 1;
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_local_variable);
        v_local_variable := v_local_variable + 1;
    END AFTER STATEMENT;
    
END;
/


INSERT INTO ANIMAL VALUES(77,'Cheetah');

INSERT INTO ANIMAL VALUES(33,'Whale');


------------------------------------------------------------
-------- DDL TRIGGERS 
-----------------------------------------------------------
-- DEFINE FOR DATA DEFINITION LANGUAGE(DDL) SQL
    -- CREATE 
    -- ALTER
    -- DROP
-- CREATED FOR SCHEMA OR DATABASE
-- ACCESS TO DDL DETAILS WITHIN TRIGGER SUCH AS
    -- ORA_DICT_OBJ_NAME = OBJECT NAME
    -- ORA_DICT_OBJ_TYPE = OBJECT TYPE
------------------------------------------------------------

-- CREATE A TRIGER TO PREVENT ALL DDL IN THE CURRENT SCHEMA
CREATE OR REPLACE TRIGGER no_ddl
BEFORE DDL
ON SCHEMA 
BEGIN
    RAISE_aPPLICATION_ERROR(-20000, 'No DDL Allowed');
END;
/


--TRY DROP A TABLE
DROP TABLE ANIMAL;
DROP TABLE DOES_NOT_EXISTS;

-- DROP THE UNDROPPED TRIGGER
DROP TRIGGER no_ddl;


-- CREATE A TRIGGER TO MONITOR ALL CREATES
CREATE OR REPLACE TRIGGER before_create
BEFORE CREATE 
ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('You CrEated A '|| ORA_DICT_OBJ_TYPE||
                        ' Named '         || ORA_DICT_OBJ_NAME);
END;
/


-- CREATE TABLE AND INDEX
CREATE TABLE ABC123
(COL1 NUMBER);
CREATE INDEX ABC_IX ON ABC123 (COL1);

-- DROP THE CREATE TRIGGER
DROP TRIGGER BEFORE_CREATE;



-- CREATE TRIGGER TO TRACT SPECIFIC DDL EVENTS
CREATE OR REPLACE TRIGGER all_ddl
BEFORE DDL
ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('That Was A '|| ORA_SYSEVENT);
END;
/

DROP TABLE ABC123;

DROP TRIGGER all_ddl;



CREATE OR REPLACE TRIGGER get_ddl
BEFORE DDL
ON SCHEMA
DECLARE
    v_ddl_linecount NUMBER;
    v_sql           ORA_NAME_LIST_T;
BEGIN
    v_ddl_linecount := ORA_SQL_TXT(V_SQL);
    FOR counter IN 1..v_ddl_linecount LOOP
        DBMS_OUTPUT.PUT_LINE(counter || ' ' || v_sql(counter));
    END LOOP;
END;
/
        


CREATE TABLE BOB (COL1 NUMBER);

ALTER TABLE BOB ADD (COL2 NUMBER);


-- TRIGGER CATHES DYNAMIC DDL AS WELL
CREATE OR REPLACE PROCEDURE no_bob AS 
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BOB';
END;
/


BEGIN
    no_bob;
END;
/


DROP TRIGGER get_ddl;


CREATE TABLE BOB (COL1 NUMBER);

CREATE OR REPLACE TRIGGER get_grants
BEFORE DDL
ON SCHEMA
DECLARE
    v_priv_count    NUMBER;
    v_prIvs         ORA_NAME_LIST_T;
BEGIN
    v_priv_count := ORA_PRIVILEGE_LIST(v_privs);
    DBMS_OUTPUT.PUT_LINE('Actual provileges granted');
    FOR counter in 1..v_priv_count LOOP
        DBMS_OUTPUT.PUT_LINE(v_privs(COUNTER));
    END LOOP;
END;
/



GRANT ALL ON BOB TO PUBLIC;


DROP TRIGGER get_grants;


--- CREATE A DDL TRIGGER TAHT WILL FAIL
CREATE OR REPLACE TRIGGER raise_exception
BEFORE DDL
ON SCHEMA
DECLARE
    v_number number;
BEGIN
    v_number := 'abc';
END;
/


CREATE TABLE ABC123 (COL1 NUMBER);


--- CREATE TRIGGER THAT WILL RAISSE NO DATA FOUND
CREATE OR REPLACE TRIGGER raise_exception
BEFORE DDL
ON SCHEMA
DECLARE
    v_number number;
BEGIN
    SELECT ANIMAL_ID
    INTO V_NUMBER
    FROM ANIMAL
    WHERE 1=2;
END;
/

CREATE TABLE ABC123 (COL1 NUMBER);


DROP TRIGGER RAISE_EXCEPTION;

DROP TABLE ANIMAL;
DROP TABLE ANIMAL_STRIPES;


----------------------------------------------------------------
--- INSTEAD OF TRIGGER
----------------------------------------------------------------
-- DEFIND FOR VIEWS
-- DEFINE BEHAVIOR FOR DML AGAINST THE VIEW
    -- INSERT
    -- UPDATE
    -- DELETE

----------------------------------------------------------------

CREATE TABLE ANIMAL
(ANIMAL_ID NUMBER NOT NULL,
ANIMAL_NAME VARCHAR2(30) NOT NULL);


CREATE TABLE ANIMAL_STRIPES
(ANIMAL_ID NUMBER NOT NULL,
 STRIPE_ID  NUMBER NOT NULL,
STRIPE_COLOR VARCHAR2(30) NOT NULL);

-- CREATE VIEW TO DISPLAY ANIMAL ADN FIRST 2 STRIPES
CREATE VIEW animal_with_stipes AS
SELECT animal_name,
    (SELECT stripe_color 
        FROM ANIMAL_STRIPES 
        WHERE animal_id = animal.animal_id
        AND stripe_id = 1) AS stripe_one,
    (SELECT stripe_color 
        FROM ANIMAL_STRIPES 
        WHERE animal_id = animal.animal_id
        AND stripe_id = 2) AS stripe_TWO
    FROM ANIMAL;
    
SELECT * FROM animal_with_stipes;
     
-- INSERT AN ENTRY FOR ZEBRA
INSERT INTO animal_with_stipes
VALUES('ZEBRA','White','Black');


-- CREATE INSTEAD OF TRIGGER STRUB
CREATE TRIGGER insert_animal_with_stripes
INSTEAD OF INSERT 
ON animal_with_stipes
BEGIN
    NULL;
END;
/

-- ADD QUERIES TO GET NEXT I D VALUES
CREATE OR REPLACE TRIGGER insert_animal_with_stipes
INSTEAD OF INSERT
ON animal_with_stipes
DECLARE
    v_animal_id NUMBER;
    v_stripe_id NUMBER;
BEGIN
    -- USE ROWCOUNT +1 FOR ANIMAL ID
    SELECT COUNT(*) + 1 
    INTO v_animal_id 
    FROM animal;
    DBMS_OUTPUT.PUT_LINE('nEW ANIMAL ID '|| v_animal_id);
    
    -- USE ROWCOUNT + 1 FOR STRIPE ID
    SELECT COUNT(*) + 1 
    INTO v_stripe_id 
    FROM animal_stripes
    WHERE animal_id = v_animal_id;

END;
/


-- ADD QUERIES TO GET NEXT I D VALUES
CREATE OR REPLACE TRIGGER insert_animal_with_stipes
INSTEAD OF INSERT
ON animal_with_stipes
DECLARE
    v_animal_id NUMBER;
    v_stripe_id NUMBER;
BEGIN
    -- USE ROWCOUNT +1 FOR ANIMAL ID
    SELECT COUNT(*) + 1 
    INTO v_animal_id 
    FROM animal;
    DBMS_OUTPUT.PUT_LINE('nEW ANIMAL ID '|| v_animal_id);

    --CREATE ENTRY IN ANIMAL TABLE
    INSERT INTO ANIMAL
    VALUES (v_animal_id, :NEW.animal_name);
    
    -- USE ROWCOUNT + 1 FOR STRIPE ID
    SELECT COUNT(*) + 1 
    INTO v_stripe_id 
    FROM animal_stripes
    WHERE animal_id = v_animal_id;
    DBMS_OUTPUT.PUT_LINE('nEW STRIPE ID '|| v_stripe_id);

    --CREATE FIRST STRIPE ENRTRY
    INSERT INTO animal_stripes
    VALUES (v_animal_id,v_stripe_id, :NEW.stripe_one);
    
    
    -- USE ROWCOUNT + 1 FOR STRIPE ID
    SELECT COUNT(*) + 1 
    INTO v_stripe_id 
    FROM animal_stripes
    WHERE animal_id = v_animal_id;
    DBMS_OUTPUT.PUT_LINE('nEW STRIPE ID '|| v_stripe_id);
    
    --CREATE SECOND STRIPE ENRTRY
    INSERT INTO animal_stripes
    VALUES (v_animal_id,v_stripe_id, :NEW.stripe_two);
    
END;
/


    
-- INSERT AN ENTRY FOR ZEBRA
INSERT INTO animal_with_stipes
VALUES('zEBRA','White','Black');


SELECT * FROM animal_with_stipes;

COMMIT;

UPDATE animal_with_stipes SET 
    STRIPE_ONE = 'RED',
    STRIPE_TWO = 'BLUE'
WHERE animal_name = 'ZEBRA';



-- CREATE TRIGGER STUB FOR UPDATE
CREATE OR REPLACE TRIGGER update_animal_with_stripes
INSTEAD OF UPDATE
ON animal_with_stipes
BEGIN
    NULL;
END;
/

SELECT * FROM animal_with_stipes;

--CREATE TRIGGER TO HANDLE UPDATES OF STRIPE COLOUR
CREATE OR REPLACE TRIGGER update_animal_with_stripes
INSTEAD OF UPDATE
ON animal_with_stipes
BEGIN
    
    UPDATE animAl_stripes 
    SET stripe_color =  :NEW.stripe_one
    WHERE ANIMAL_ID = (SELECT animal_id 
                    FROM ANIMAL
                    WHERE animal_name = :NEW.animal_name)
    AND stripe_id = 1;
    
    DBMS_OUTPUT.PUT_LINE('UPDATED '||SQL%ROWCOUNT);
    
    UPDATE animAl_stripes 
    SET stripe_color =  :NEW.stripe_TWO
    WHERE ANIMAL_ID = (SELECT animal_id 
                    FROM ANIMAL
                    WHERE animal_name = :NEW.animal_name)
    AND stripe_id = 2;
    
    DBMS_OUTPUT.PUT_LINE('UPDATED '||SQL%ROWCOUNT);
    
END;
/



--CREATE TRIGGER TO HANDLE UPDATES OF STRIPE COLOUR
-- ..BUT ONLY IF THE COLOR ACTAUALLY CHANGED
CREATE OR REPLACE TRIGGER update_animal_with_stripes
INSTEAD OF UPDATE
ON animal_with_stipes
BEGIN
    
    UPDATE animAl_stripes 
    SET stripe_color =  :NEW.stripe_one
    WHERE ANIMAL_ID = (SELECT animal_id 
                    FROM ANIMAL
                    WHERE animal_name = :NEW.animal_name)
    AND stripe_id = 1
    AND STRIPE_COLOR <> :NEW.STRIPE_ONE;
    
    DBMS_OUTPUT.PUT_LINE('UPDATED '||SQL%ROWCOUNT);
    
    UPDATE animAl_stripes 
    SET stripe_color =  :NEW.stripe_TWO
    WHERE ANIMAL_ID = (SELECT animal_id 
                    FROM ANIMAL
                    WHERE animal_name = :NEW.animal_name)
    AND stripe_id = 2
    AND STRIPE_COLOR <> :NEW.STRIPE_TWO;
    
    DBMS_OUTPUT.PUT_LINE('UPDATED '||SQL%ROWCOUNT);
    
END;
/


-- COMPARE OLD AND NEW VALUES TO SEE IF HTE ANTYTHING ACTUALLY CHANGED
CREATE OR REPLACE TRIGGER update_animal_with_stripes
INSTEAD OF UPDATE
ON animal_with_stipes
BEGIN
    IF :NEW.animal_name = :OLD.animal_name THEN
        RAISE_APPLICATION_ERROR(-20000,'Name is already set to '|| :OLD.ANIMAL_NAME);
    END IF ;
END;
/

UPDATE animal_with_stipes SET ANIMAL_NAME = 'ZEBRA';
