/* viewing tables */

SELECT owner, table_name FROM all_tables;

SELECT owner, table_name
FROM all_tables
WHERE owner = 'DWT_BRANCH_1';

SELECT owner, table_name
FROM all_tables
WHERE owner = 'DWT_BRANCH_3';

SELECT owner, table_name
FROM all_tables
WHERE owner = 'DWT_BRANCH_2';

-- Viewing Entries of tables in each schema

SELECT * FROM DWT_BRANCH_2.CUSTOMER;
SELECT * FROM DWT_BRANCH_2.BUYS;
SELECT * FROM DWT_BRANCH_2.PRODUCT;
SELECT * FROM DWT_BRANCH_2.PLACE;


SELECT * FROM DWT_BRANCH_1.CUSTOMER;                       
SELECT * FROM DWT_BRANCH_1.ORDER;
SELECT * FROM DWT_BRANCH_1.PRODUCTS;

SELECT * FROM DWT_BRANCH_3.CUSTOMER;                       
SELECT * FROM DWT_BRANCH_3.BOTTLE;
SELECT * FROM DWT_BRANCH_3.SORT;
SELECT * FROM DWT_BRANCH_3.ORDER;


/* viewing attributes and datatypes of each table */

DESCRIBE DWT_BRANCH_1.CUSTOMER;                       
DESCRIBE DWT_BRANCH_1.ORDER;
DESCRIBE DWT_BRANCH_1.PRODUCTS;

DESCRIBE DWT_BRANCH_2.CUSTOMER;                       
DESCRIBE DWT_BRANCH_2.BUYS;
DESCRIBE DWT_BRANCH_2.PLACE;
DESCRIBE DWT_BRANCH_2.PRODUCT;

DESCRIBE DWT_BRANCH_3.CUSTOMER;                       
DESCRIBE DWT_BRANCH_3.BOTTLE;
DESCRIBE DWT_BRANCH_3.SORT;
DESCRIBE DWT_BRANCH_3.ORDER;


-- View key constraints of Tables

SELECT * FROM all_cons_columns;


-- Get all tables assigned to each branch

SELECT table_name
FROM all_tables;

-- Generating CREATE statements for tables in a specific schema (DWT_GROUP02)

SET PAGESIZE 0
SET LONG 100000
SET LONGCHUNKSIZE 100000
SET TRIMOUT ON
SET TRIMSPOOL ON

SPOOL create_tables.sql

-- Specify the schema name
DEFINE schema_name = 'DWT_GROUP02'

-- Retrieve the table names within the schema
SELECT 'CREATE TABLE ' || table_name || ' AS' || DBMS_METADATA.GET_DDL('TABLE', table_name, '&schema_name') || ';' AS create_statement
FROM all_tables
WHERE owner = UPPER('&schema_name');

SPOOL OFF

-- CREATE statements

CREATE TABLE BRANCH3_SORT (
  SID NUMBER(2) NOT NULL,
  "NAME" VARCHAR2(20) NOT NULL
);

CREATE TABLE BRANCH3_CUSTOMER (
  ID NUMBER(10) NOT NULL,
  "NAME" VARCHAR2(25) NOT NULL,
  "SURNAME" VARCHAR2(25) NOT NULL,
  STR VARCHAR2(50),
  "NO" VARCHAR2(5),
  ZIP CHAR(5) NOT NULL,
  PLACE VARCHAR2(60) NOT NULL,
  GEND NUMBER(1),
  BDAY DATE,
  CONSTRAINT BRANCH3_PK_CUSTOMER PRIMARY KEY ("ID")
);

CREATE TABLE BRANCH_3_BOTTLE (
  OID NUMBER(2) NOT NULL,
  VOL NUMBER(3,2),
  UNIT VARCHAR2(15) NOT NULL,
  CONSTRAINT BRANCH_3_PK_BOTTLE PRIMARY KEY ("OID")

);

CREATE TABLE BRANCH3_ORDERS (
  "ORDER" NUMBER(15) NOT NULL,
  "DATE" DATE NOT NULL,
  AMOUNT NUMBER(5) NOT NULL,
  CSTMR NUMBER(10),
  PRO NUMBER(10),
  CONSTRAINT BRANCH3_FK_PURCHASE_CUSTOMER FOREIGN KEY (CSTMR) REFERENCES BRANCH3_CUSTOMER(ID)
);


CREATE TABLE BRANCH2_PLACE (
    PLID NUMBER(5) NOT NULL,
    STR_NO VARCHAR2(70),
    ZIP_PLACE VARCHAR2(100) NOT NULL,
    PRIMARY KEY (PLID)
);
CREATE TABLE BRANCH2_CUSTOMER (
    "NUM" NUMBER(12) NOT NULL,
    LASTNAME VARCHAR2(50) NOT NULL,
    FIRSTNAME VARCHAR2(50),
    PLACEID NUMBER(5),
    BDAY DATE,
    CONSTRAINT BRANCH2_CUSTOMER_PK PRIMARY KEY (NUM),
    CONSTRAINT BRANCH2_CUSTOMER_FK_PLACEID FOREIGN KEY (PLACEID) REFERENCES BRANCH2_PLACE(PLID)
);
CREATE TABLE BRANCH2_PRODUCT (
  "NUM" NUMBER(12) NOT NULL,
  "LABEL" VARCHAR2(40) NOT NULL,
  "TYPE" VARCHAR2(30) NOT NULL,
  LITER NUMBER(3,2) NOT NULL,
  PRICE VARCHAR2(10) NOT NULL,
  CONSTRAINT BRANCH2_PK_PRODUCT PRIMARY KEY ("NUM")
);

CREATE TABLE BRANCH2_BUYS (
  CNUMBER NUMBER(10) NOT NULL,
  PNUMBER NUMBER(10) NOT NULL,
  AMOUNT VARCHAR2(5) NOT NULL,
  "DATE" DATE NOT NULL,

    
  CONSTRAINT BRANCH2_FK_PURCHASE_CUSTOMER FOREIGN KEY (CNUMBER) REFERENCES BRANCH2_CUSTOMER(NUM),
  CONSTRAINT BRANCH2_FK_PURCHASE_PRODUCT FOREIGN KEY (PNUMBER) REFERENCES BRANCH2_PRODUCT(NUM)
);

CREATE TABLE BRANCH1_PRODUCTS (
  ID NUMBER(11) NOT NULL,
  "NAME" VARCHAR2(50) NOT NULL,
  "SORT" VARCHAR2(20) NOT NULL,
  SZ NUMBER(3,2) NOT NULL,
  PRICE NUMBER(3,2) NOT NULL,
  CONSTRAINT BRANCH1_PK_PRODUCTS PRIMARY KEY ("ID")
);

CREATE TABLE BRANCH1_CUSTOMER (
    ID NUMBER(11) NOT NULL,
    "NAME" VARCHAR2(40) ,
    SURNAME VARCHAR2(40)NOT NULL,
    STR VARCHAR2(60),
    "NO" VARCHAR2(5),
    ZIP VARCHAR2(5)NOT NULL,
    PLACE VARCHAR2(50),
    GEND CHAR(1),
    BDAY DATE,
    CONSTRAINT BRANCH1_PK_CUSTOMER PRIMARY KEY ("ID")

);

CREATE TABLE BRANCH1_ORDER(
    "ORDER" VARCHAR2(15) NOT NULL,
    "DATE" DATE NOT NULL,
    AMOUNT CHAR(5) NOT NULL,
    CSTMR NUMBER(11),
    PRO NUMBER(11),
    CONSTRAINT BRANCH1_FK_PURCHASE_CUSTOMER FOREIGN KEY (CSTMR) REFERENCES BRANCH1_CUSTOMER(ID),
    CONSTRAINT BRANCH1_FK_PURCHASE_PRODUCTS FOREIGN KEY (PRO) REFERENCES BRANCH1_PRODUCTS(ID)

);