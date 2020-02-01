connect /as sysdba
DROP TABLE hr.list_customers PURGE;
CREATE TABLE hr.list_customers 
   ( customer_id             NUMBER(6)
   , cust_first_name         VARCHAR2(20) 
   , cust_last_name          VARCHAR2(20)
   , cust_address            CHAR(30)
   , nls_territory           VARCHAR2(30)
   , cust_email              VARCHAR2(40))
   PARTITION BY LIST (nls_territory) (
   PARTITION asia VALUES ('CHINA', 'THAILAND'),
   PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND'),
   PARTITION west VALUES ('AMERICA'),
   PARTITION east VALUES ('INDIA'),
   PARTITION rest VALUES (DEFAULT));

set pagesize 200
col table_name format a20
col partition_name format a30

select table_name,partition_name
from dba_tab_partitions
where table_name = 'LIST_CUSTOMERS';

select table_name,partition_name
from dba_tab_partitions
where table_name = 'EXCHANGE_TABLE';

DROP TABLE hr.exchange_table  PURGE;
CREATE TABLE hr.exchange_table (
   customer_id     NUMBER(6),
   cust_first_name VARCHAR2(20),
   cust_last_name  VARCHAR2(20),
   cust_address    CHAR(30),
   nls_territory   VARCHAR2(30),
   cust_email      VARCHAR2(40));

exec dbms_stats.gather_table_stats('HR','EXCHANGE_TABLE');

ALTER TABLE hr.list_customers 
   EXCHANGE PARTITION rest WITH TABLE hr.exchange_table 
   WITHOUT VALIDATION;

select table_name,partition_name
from dba_tab_partitions
where table_name = 'LIST_CUSTOMERS';

select table_name,partition_name
from dba_tab_partitions
where table_name = 'EXCHANGE_TABLE';

