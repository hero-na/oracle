connect /as sysdba

DROP TABLE scott.sales_items PURGE;
DROP TABLE scott.sales PURGE;

DROP TABLESPACE SALES_100_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_1000_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_3000_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_6000_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_MAX_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE SALES_100_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_100_tbs01.dbf' size 20 M;
CREATE TABLESPACE SALES_1000_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_1000_tbs01.dbf' size 20 M;
CREATE TABLESPACE SALES_3000_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_3000_tbs01.dbf' size 20 M;
CREATE TABLESPACE SALES_6000_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_6000_tbs01.dbf' size 20 M;
CREATE TABLESPACE SALES_MAX_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_max_tbs01.dbf' size 20 M;


CREATE TABLE scott.sales
        (sales_no 	NUMBER(2)	NOT NULL,
         sales_date 	DATE		NOT NULL,
 	 sales_region	CHAR(2),
         customer_id    NUMBER(5),
         sales_quantity NUMBER(5),
         price 		NUMBER(8),
         total_sales_price as (sales_quantity * price) VIRTUAL 
         )
PARTITION BY RANGE (total_sales_price)
       (
	PARTITION sales_lessthan_1 VALUES LESS THAN (100) TABLESPACE SALES_100_TBS,
	PARTITION sales_lessthan_1000 VALUES LESS THAN (1000) TABLESPACE SALES_1000_TBS,
	PARTITION sales_lessthan_3000 VALUES LESS THAN (3000) TABLESPACE SALES_3000_TBS,
	PARTITION sales_lessthan_6000 VALUES LESS THAN (6000) TABLESPACE SALES_6000_TBS,
	PARTITION sales_max VALUES LESS THAN (maxvalue) TABLESPACE SALES_MAX_TBS
	);

INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) 
VALUES (1,'21-FEB-2013','NJ',8722,10,14);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (2,'23-JUN-2014','NY',8722,28,22);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (3,'16-DEC-2015','CA',8723,40,15);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (4,'09-MAR-2016','PA',8724,100,18);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (5,'19-APR-2013','PA',8725,210,44);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (6,'31-MAY-2013','NJ',8725,30,51);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price)  VALUES (7,'17-MAR-2013','NY',8726,1,38);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (8,'27-NOV-2015','NY',8723,32,39);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (9,'15-JUN-2014','CA',8723,322,11);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (10,'25-MAY-2015','NJ',8723,96,23);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (11,'21-FEB-2013','NJ',8262,43,14);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (12,'23-JUN-2014','NY',8722,211,22);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (13,'16-DEC-2015','CA',8523,500,15);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (14,'09-MAR-2016','PA',8764,344,28);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (15,'19-APR-2013','PA',8729,330,44);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (16,'31-MAY-2013','NJ',8725,326,31);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (17,'17-MAR-2013','NY',8226,500,38);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (18,'27-NOV-2015','NY',8323,300,39);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (19,'15-JUN-2014','CA',8743,441,16);
INSERT INTO scott.sales (sales_no,sales_date,sales_region,customer_id,sales_quantity,price) VALUES (20,'25-MAY-2015','NJ',8723,98,23);
Commit;


EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
col table_name format a20
col partition_name format a30
col num_rows format 9999
col high_value format a20
set linesize 120
set pagesize 200
SELECT table_name, partition_name, num_rows, high_value
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name; 


col sales_no format 999
col sales_region format a5
col customer_id format 99999
col price format 99999
select * from scott.sales order by sales_no;

select * from scott.sales partition(SYS_P601) order by sales_no;


