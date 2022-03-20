DECLARE
    l_var VARCHAR2(1000) := 'ABC';
    l_num NUMBER            := 1.23;
    l_i NUMBER                  := 1.3;
    l_p PLS_INTEGER         := 1.4;
BEGIN
    DBMS_OUTPUT.PUT_LINE(l_var);
    DBMS_OUTPUT.PUT_LINE(l_num);
    DBMS_OUTPUT.PUT_LINE(l_i);
    DBMS_OUTPUT.PUT_LINE(l_p);
END;
/

-- ORA-06502: PL/SQL: numeric or value error: character string buffer too small
DECLARE
    -- stuff too many charachters in 
    l_var2 VARCHAR2(1) ;
BEGIN
    l_var2 := 'A';
    l_var2 := l_var2 || 'B';
    DBMS_OUTPUT.PUT_LINE(l_var2);
END;
/

-- ORA-06502: PL/SQL: numeric or value error: character to number conversion error
DECLARE
    -- cannot put variabel value in numeric variable
    l_var2 NUMBER;
BEGIN
    l_var2 := 'A';
END;
/



create table animal (animal_id number, animal_name varchar2(30));

INSERT INTO ANIMAL values(1,'TIGER');

commit;

-- ORA-06502: PL/SQL: numeric or value error: character string buffer too small
DECLARE
    v_animal_name varchar2(2);
BEGIN
        SELECT animal_name INTO v_animal_name from 
            ANIMAL;
        DBMS_OUTPUT.PUT_LINE(v_animal_name);
END;
/


DECLARE
    v_animal_name animal.animal_name%TYPE;
BEGIN
        SELECT animal_name INTO v_animal_name from 
            ANIMAL;
        DBMS_OUTPUT.PUT_LINE(v_animal_name);
END;
/

