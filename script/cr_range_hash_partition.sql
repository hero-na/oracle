connect /as sysdba
DROP TABLE scott.sales PURGE;

DROP TABLESPACE SALES_2013_SALESNO_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_2014_SALESNO_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_2015_SALESNO_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_2016_SALESNO_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE SALES_2013_SALESNO_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_2013_salesno_tbs01.dbf' size 10 M 
autoextend on next 10 m maxsize 100 m;
CREATE TABLESPACE SALES_2014_SALESNO_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_2014_salesno_tbs01.dbf' size 10 M 
autoextend on next 10 m maxsize 100 m;
CREATE TABLESPACE SALES_2015_SALESNO_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_2015_salesno_tbs01.dbf' size 10 M 
autoextend on next 10 m maxsize 100 m ;
CREATE TABLESPACE SALES_2016_SALESNO_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_2016_salesno_tbs01.dbf' size 10 M 
autoextend on next 10 m maxsize 100 m;


CREATE TABLE scott.sales
        (sales_no 	NUMBER(2)	NOT NULL,
         sales_date 	DATE		NOT NULL,
 	 sales_region	CHAR(2),
         customer_id    NUMBER(5),
         price 		NUMBER(8))
PARTITION BY RANGE (sales_date)
SUBPARTITION BY HASH(sales_no)
      	SUBPARTITIONS 4
	STORE IN (sales_2013_SALESNO_TBS, sales_2014_SALESNO_TBS, sales_2015_SALESNO_TBS, sales_2016_SALESNO_TBS)
	(PARTITION sales_2013 VALUES LESS THAN (to_date('01-JAN-2014','dd-MON-yyyy')),
       	PARTITION sales_2014 VALUES LESS THAN (to_date('01-JAN-2015','dd-MON-yyyy')),
       	PARTITION sales_2015 VALUES LESS THAN (to_date('01-JAN-2016','dd-MON-yyyy')),
       	PARTITION sales_2016 VALUES LESS THAN (to_date('01-JAN-2017','dd-MON-yyyy'))
     	);


INSERT INTO scott.sales VALUES (1,'21-FEB-2013','NJ',8722,14);
INSERT INTO scott.sales VALUES (2,'23-JUN-2014','NY',8722,22);
INSERT INTO scott.sales VALUES (3,'16-DEC-2015','CA',8723,15);
INSERT INTO scott.sales VALUES (4,'09-MAR-2016','PA',8724,18);
INSERT INTO scott.sales VALUES (5,'19-APR-2013','PA',8725,44);
INSERT INTO scott.sales VALUES (6,'31-MAY-2013','NJ',8725,51);
INSERT INTO scott.sales VALUES (7,'17-MAR-2013','NY',8726,38);
INSERT INTO scott.sales VALUES (8,'27-NOV-2015','NY',8723,39);
INSERT INTO scott.sales VALUES (9,'15-JUN-2014','CA',8723,11);
INSERT INTO scott.sales VALUES (10,'25-MAY-2015','NJ',8723,23);
INSERT INTO scott.sales VALUES (11,'21-FEB-2013','NJ',8262,14);
INSERT INTO scott.sales VALUES (12,'23-JUN-2014','NY',8722,22);
INSERT INTO scott.sales VALUES (13,'16-DEC-2015','CA',8523,15);
INSERT INTO scott.sales VALUES (14,'09-MAR-2016','PA',8764,28);
INSERT INTO scott.sales VALUES (15,'19-APR-2013','PA',8729,44);
INSERT INTO scott.sales VALUES (16,'31-MAY-2013','NJ',8725,31);
INSERT INTO scott.sales VALUES (17,'17-MAR-2013','NY',8226,38);
INSERT INTO scott.sales VALUES (18,'27-NOV-2015','NY',8323,39);
INSERT INTO scott.sales VALUES (19,'15-JUN-2014','CA',8743,16);
INSERT INTO scott.sales VALUES (20,'25-MAY-2015','NJ',8723,23);
Commit;


EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
col tablespace_name format a24
col partition_name format a20
col subpartition_name format a20
col num_rows format 9999
set linesize 120
set pagesize 200
SELECT partition_name, tablespace_name,subpartition_name, num_rows
FROM dba_tab_subpartitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name; 
col sales_no format 999
col sales_region format a5
col customer_id format 99999
col price format 99999
select * from scott.sales order by sales_no;

select * from scott.sales partition (SALES_2013) order by sales_no;
select * from scott.sales subpartition () order by sales_no;

