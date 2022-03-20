-- Sql Query - in the case the sql developre
-- enviroenment takes care of acceptiong and displaying
-- teh return values

select * from animal;

-- when writeing PLSQL we have to control where to quered
-- values are stored and if required where to displayed

DECLARE
    CURSOR cur_get_animal IS
        SELECT * FROM ANIMAL;
    v_animal ANIMAL%ROWTYPE;
BEGIN
    OPEN cur_get_animal;
    LOOP 
        FETCH cur_get_animal INTO v_animal;
        EXIT WHEN cur_get_animal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_animal.animal_id || '  ' ||
                v_animal.animal_name);
    END LOOP;
    CLOSE cur_get_animal;
END;
/



-- when writeing PLSQL we have to control where to quered
-- values are stored and if required where to displayed
-- and we have to make sure the input paramater is used

SELECT * FROM ANIMAL
where animal_id = 1;

-- pass paramtere to curror to accept it 
CREATE OR REPLACE PROCEDURE show_animal ( p_id NUMBER ) IS
    CURSOR cur_get_animal ( cp_id NUMBER) IS
        SELECT * FROM 
            ANIMAL WHERE 
            animal_id = cp_id;
    V_ANIMAL ANIMAL%ROWTYPE;
BEGIN
    OPEN cur_get_animal(p_id);
    LOOP
        FETCH cur_get_animal INTO V_ANIMAL;
        EXIT WHEN cur_get_animal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_animal.animal_id || '  ' ||
                v_animal.animal_name);
    END LOOP;
    CLOSE cur_get_animal;
END;
/

BEGIN
    show_animal(1);
END;
