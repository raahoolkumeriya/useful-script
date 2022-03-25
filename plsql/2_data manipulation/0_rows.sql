DECLARE
    --variabel anchored to whole row
    v_animal_row ANIMAL%ROWTYPE;
BEGIN
        v_animal_row.animal_id := 2;
        v_animal_row.animal_name := 'ZEBRA';
END;
/


DECLARE
    -- variabel anchored to whole row
    -- with quite
    v_animal_row ANIMAL%ROWTYPE;
BEGIN
    select * into v_animal_row 
    from ANIMAL;
END;
/


DECLARE
    --variabel anchored to whole row
    v_animal_row ANIMAL%ROWTYPE;
BEGIN
        v_animal_row.animal_id := 2;
        v_animal_row.animal_name := 'ZEBRA';
        INSERT INTO ANIMAL values v_animal_row;
END;
/

select * from ANIMAL;

commit;