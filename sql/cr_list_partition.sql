connect /as sysdba

DROP TABLE scott.sales PURGE;
DROP TABLE scott.sales2 PURGE;

DROP TABLESPACE SALES_NJ_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_NY_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_CA_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_PA_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_AZ_TBS INCLUDING CONTENTS AND DATAFILES;


CREATE TABLESPACE SALES_NJ_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_NJ_tbs01.dbf' size 10 M autoextend on next 10M maxsize 100m;
CREATE TABLESPACE SALES_NY_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_NY_tbs01.dbf' size 10 M autoextend on next 10M maxsize 100m;
CREATE TABLESPACE SALES_CA_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_CA_tbs01.dbf' size 10 M autoextend on next 10M maxsize 100m;
CREATE TABLESPACE SALES_PA_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_PA_tbs01.dbf' size 10 M autoextend on next 10M maxsize 100m;

CREATE TABLE scott.sales
        (sales_no 	NUMBER(2)	NOT NULL,
         sales_date 	DATE		NOT NULL,
 	 sales_region	CHAR(2),
         customer_id    NUMBER(5),
         price 		NUMBER(8))
PARTITION BY LIST (sales_region)
       (PARTITION sales_NJ VALUES('NJ')  TABLESPACE SALES_NJ_TBS, 
       PARTITION sales_NY VALUES('NY')  TABLESPACE SALES_NY_TBS, 
       PARTITION sales_CA VALUES('CA')  TABLESPACE SALES_CA_TBS,
       PARTITION sales_PA VALUES('PA')  TABLESPACE SALES_PA_TBS); 

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

select * from scott.sales partition(SALES_CA) order by sales_no;
INSERT INTO scott.sales partition(SALES_CA) values (30,'17-OCT-2013','CA',8226,21);
commit;
select * from scott.sales partition(SALES_CA) order by sales_no;

delete from scott.sales partition(SALES_CA);
commit;
select * from scott.sales partition(SALES_CA) order by sales_no;


SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

CREATE TABLESPACE SALES_AZ_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_AZ_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;

alter table scott.sales add partition SALES_AZ values ('AZ') tablespace SALES_AZ_TBS;

EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales drop partition sales_AZ;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;


alter table scott.sales rename partition sales_PA to sales_WEST_PA;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales rename partition sales_WEST_PA to sales_PA;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales move partition sales_PA tablespace SALES_NY_TBS;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

alter table scott.sales move partition sales_PA tablespace SALES_PA_TBS;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;


alter table scott.sales merge partitions sales_NY,sales_NJ
into partition sales_NORTHEAST;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

ALTER TABLE scott.sales
SPLIT PARTITION sales_NORTHEAST
VALUES ('NY')
INTO (
           PARTITION sales_NY TABLESPACE sales_NY_TBS,
	   PARTITION sales_NJ TABLESPACE sales_NJ_TBS);

EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;


select * from scott.sales partition(sales_CA) order by sales_no;
delete from scott.sales partition(sales_CA);
commit;
select * from scott.sales partition(sales_CA) order by sales_no;

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


alter table scott.sales exchange partition sales_CA with table scott.sales2;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
select * from scott.sales partition(sales_CA) order by sales_no;
select * from scott.sales2 order by sales_no;

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;








