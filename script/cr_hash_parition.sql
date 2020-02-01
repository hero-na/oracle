connect /as sysdba
DROP TABLE scott.sales PURGE;
DROP TABLE scott.sales2 PURGE;

DROP TABLESPACE SALES_TBS_1 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_2 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_3 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_4 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_5 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_HASH_TBS INCLUDING CONTENTS AND DATAFILES;


CREATE TABLESPACE SALES_TBS_1 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE SALES_TBS_2 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs02.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE SALES_TBS_3 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs03.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE SALES_TBS_4 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs04.dbf' size 10 M autoextend on next 10m maxsize 100m;

DROP TABLE scott.sales PURGE;

CREATE TABLE scott.sales
        (sales_no 	NUMBER(2)	NOT NULL,
         sales_date 	DATE		NOT NULL,
 	 sales_region	CHAR(2),
         customer_id    NUMBER(5),
         price 		NUMBER(8))
PARTITION BY HASH (sales_no)
       	PARTITIONS 4 STORE IN (SALES_TBS_1, SALES_TBS_2, SALES_TBS_3, SALES_TBS_4);


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

col sales_no format 999
col sales_region format a5
col customer_id format 99999
col price format 99999
select * from scott.sales order by sales_no;


EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
col tablespace_name format a20
col partition_name format a20
col num_rows format 9999
set linesize 120
set pagesize 200

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

select * from scott.sales partition(SYS_P648) order by sales_no;
INSERT INTO scott.sales partition(SYS_P648) values (30,'17-OCT-2013','CA',8226,21);
commit;
select * from scott.sales partition(SYS_P648) order by sales_no;

delete from scott.sales partition(SYS_P648);
commit;
select * from scott.sales partition(SYS_P648) order by sales_no;


SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

CREATE TABLESPACE SALES_HASH_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_hash_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;

alter table scott.sales add partition ;
alter table scott.sales add partition SALES_HASH tablespace SALES_HASH_TBS;

EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales drop partition SALES_HASH;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;


alter table scott.sales rename partition SYS_P648 to sales_TEMP;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales rename partition sales_TEMP to SYS_P648;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales move partition SYS_P648 tablespace SALES_TBS_5;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales move partition SYS_P648 tablespace SALES_TBS_1;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;


alter table scott.sales merge partitions SYS_P650,SYS_P651
into partition SYS_P650_P651;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

select * from scott.sales partition(SYS_P651) order by sales_no;
delete from scott.sales partition(SYS_P651);
commit;
select * from scott.sales partition(SYS_P651) order by sales_no;

CREATE TABLE scott.sales2
        (sales_no       NUMBER(2)       NOT NULL,
         sales_date     DATE            NOT NULL,
         sales_region   CHAR(2),
         customer_id    NUMBER(5),
         price          NUMBER(8));

INSERT INTO scott.sales2 VALUES (1,'21-FEB-2014','CA',8722,14);
INSERT INTO scott.sales2 VALUES (2,'23-JUN-2013','CA',8722,22);
INSERT INTO scott.sales2 VALUES (3,'16-DEC-2015','CA',8723,15);
commit;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES2');
select * from scott.sales2 order by sales_no;


alter table scott.sales exchange partition SYS_P651 with table scott.sales2;
alter table scott.sales exchange partition SYS_P651 with table scott.sales2 without validation;

EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
select * from scott.sales partition(SYS_P651) order by sales_no;
select * from scott.sales2 order by sales_no;

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;









