CREATE OR REPLACE PACKAGE citi AS
    FUNCTION p_string RETURN VARCHAR2;
END citi;
/

CREATE OR REPLACE PACKAGE BODY citi AS
    -- functin implemented
    FUNCTION p_string RETURN VARCHAR2  IS 
        BEGIN
            RETURN 'Codelocked';
        END p_string;
    END  citi;
/

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE(citi.p_string);
END;
/



CREATE OR REPLACE PACKAGE overlaoding_pkg AS
    PROCEDURE overl_method (p VARCHAR2);
    PROCEDURE overl_method (num NUMBER);
    PROCEDURE PRIVATE_method (num NUMBER);
END overlaoding_pkg;
/

CREATE OR REPLACE PACKAGE BODY overlaoding_pkg
AS
    -- iMPLEMENTED PROCEDURE
    PROCEDURE overl_method (p VARCHAR2) AS
    BEGIN
            DBMS_OUTPUT.PUT_LINE('METHOD ONE '||p);
    END;
    
    -- IMPALMNATION PROCEDURE
    PROCEDURE overl_method (num NUMBER) AS
    BEGIN
            DBMS_OUTPUT.PUT_LINE('METHOD TWO '|| num);
    END;
    -- PRIVaTE 
    PROCEDURE PRIVATE_method (num NUMBER) AS
    BEGIN
            DBMS_OUTPUT.PUT_LINE(' pRVATE METHOD '|| num);
    END;
END overlaoding_pkg;
/

BEGIN 
    overlaoding_pkg.PRIVATE_method(100000);
END;
/

