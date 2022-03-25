SELECT * FROM  ANIMAL;

DECLARE
    CURSOR V_cUR IS
    SELECT * FROM ANIMAL;
    V_ROW ANIMAL%ROWTYPE;
    TYPE v_animal_t IS TABLE OF ANIMAL%ROWTYPE;
    v_animal_table  v_animal_t := v_animal_t();
BEGIN
    OPEN V_CUR;
    -- GET RECORD ONE BY ONE
    LOOP 
        FETCH V_CUR INTO V_ROW;
        DBMS_OUTPUT.PUT_LINE('ROW COUNT '||V_CUR%ROWCOUNT );
        EXIT WHEN V_CUR%NOTFOUND;
    END LOOP;
    CLOSE V_CUR;
    
    -- GET ALL RECORDS AT ONCE
    OPEN V_CUR;
    FETCH V_CUR 
        BULK COLLECT INTO v_animal_table;
    CLOSE V_CUR;
    
    DBMS_OUTPUT.PUT_LINE('BULK COLLECT '|| v_animal_table.COUNT);
    DBMS_OUTPUT.PUT_LINE('BULK FIRST '|| v_animal_table.FIRST);
    DBMS_OUTPUT.PUT_LINE('BULK LAST '|| v_animal_table.LAST);
    FOR counter IN 1..v_animal_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('BULK '||counter ||' ' ||v_animal_table(COUNTER).ANIMAL_NAME);
    END LOOP;   
        
END;
/

-- QUERY SINGLE COLUMNS INSTEAD OF ROWS
DECLARE
    CURSOR cur_animal IS 
    SELECT * FROM ANIMAL;
    TYPE v_n_t IS TABLE OF NUMBER;
    v_n_table v_n_t := v_n_t();
    TYPE v_nC2_t IS TABLE OF VARCHAR2(30);
    v_nC2_table v_nC2_t := v_nC2_t();
BEGIN
    OPEN cur_animal;
    FETCH cur_animal 
        BULK COLLECT INTO v_n_table,v_nC2_table;
    CLOSE cur_animal;

    FOR counter IN 1..v_n_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('BULK = ' ||COUNTER||' '||
                v_n_table(counter) || ' '||
                v_nC2_table(counter) );
    END LOOP;
END;
/
    
    
-- lIMIT NUMBER OF RECORDS RETRIVED
DECLARE
    CURSOR cur_animal IS 
    SELECT * FROM ANIMAL;
    TYPE v_n_t IS TABLE OF NUMBER;
    v_n_table v_n_t := v_n_t();
    TYPE v_nC2_t IS TABLE OF VARCHAR2(30);
    v_nC2_table v_nC2_t := v_nC2_t();
BEGIN
    OPEN cur_animal;
    LOOP 
    
        FETCH cur_animal 
            BULK COLLECT INTO v_n_table,v_nC2_table LIMIT 2;
            EXIT WHEN v_n_table.COUNT = 0;
    
        FOR counter IN 1..v_n_table.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('BULK = ' ||counter||' '||
                    'cURSOR '|| cur_animal%ROWCOUNT ||' '||
                    v_n_table(counter) || ' '||
                    v_nC2_table(counter) );
        END LOOP;
    END LOOP;
    CLOSE cur_animal;
END;
/
    