CREATE OR REPLACE PACKAGE CUSTOMER_PACKAGE
    AS PROCEDURE ADD_CUSTOMER (
    c_id            IN OUT NUMBER,
    c_fname         IN VARCHAR2,
    c_lname         IN VARCHAR2,
    c_mname         IN VARCHAR2,
    c_add1          IN VARCHAR2,
    c_add2          IN VARCHAR2,
    c_city          IN VARCHAR2,
    c_country       IN VARCHAR2,
    c_date_added    IN DATE,
    c_region        IN VARCHAR2,
    t_count         OUT NUMBER
); 
PROCEDURE FETCH_SALES (
    S_ORDERID IN NUMBER, 
    L_TOTALROWS OUT NUMBER
);
PROCEDURE GET_CUSTOMER (c_id IN OUT NUMBER);

PROCEDURE GET_SALES(
    o_id IN OUT NUMBER,
    t_rows_num IN OUT NUMBER
);

FUNCTION find_salescount (p_sales_date IN date) RETURN NUMBER;

FUNCTION get_account(
    n1 IN NUMBER,
    n2 IN NUMBER

) RETURN NUMBER;

FUNCTION MY_POWER(
    n1 IN NUMBER,
    n2 IN NUMBER
) RETURN NUMBER;

END CUSTOMER_PACKAGE;
