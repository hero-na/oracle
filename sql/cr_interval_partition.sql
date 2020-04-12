connect /as sysdba
DROP TABLE scott.sales_items PURGE;
DROP TABLE scott.sales PURGE;

DROP TABLESPACE SALES_TBS_1 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_2 INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE SALES_TBS_2 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs_01.dbf' size 20M autoextend on next 10M maxsize 100M;
CREATE TABLESPACE SALES_TBS_1 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs_02.dbf' size 20M autoextend on next 10M maxsize 100M;


CREATE TABLE scott.sales
        (sales_no 	NUMBER(2)	NOT NULL,
         sales_date 	DATE		NOT NULL,
 	 sales_region	CHAR(2),
         customer_id    NUMBER(5),
         price 		NUMBER(8))
PARTITION BY RANGE (sales_date)
INTERVAL (NUMTOYMINTERVAL(1,'MONTH'))
STORE IN (SALES_TBS_1,SALES_TBS_2)
	(PARTITION sales_2013_JAN VALUES LESS THAN (to_date('01-FEB-2013','dd-MON-yyyy'))
        );

INSERT INTO scott.sales VALUES (1,'21-JAN-2013','NJ',8722,14);
INSERT INTO scott.sales VALUES (2,'23-FEB-2013','NY',8722,22);
INSERT INTO scott.sales VALUES (3,'16-MAR-2013','CA',8723,15);
INSERT INTO scott.sales VALUES (4,'09-APR-2013','PA',8724,18);
INSERT INTO scott.sales VALUES (5,'19-MAY-2013','PA',8725,44);
INSERT INTO scott.sales VALUES (6,'22-JUN-2013','NJ',8725,51);
INSERT INTO scott.sales VALUES (7,'17-JUL-2013','NY',8726,38);
INSERT INTO scott.sales VALUES (8,'27-AUG-2013','NY',8723,39);
INSERT INTO scott.sales VALUES (9,'15-SEP-2013','CA',8723,11);
INSERT INTO scott.sales VALUES (10,'25-OCT-2013','NJ',8723,23);
INSERT INTO scott.sales VALUES (11,'21-NOV-2013','NJ',8262,14);
INSERT INTO scott.sales VALUES (12,'23-DEC-2013','NY',8722,22);
Commit;



EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
col table_name format a10
col tablespace_name format a20
col partition_name format a20
col num_rows format 99
col high_value format a20
set linesize 120
set pagesize 200
SELECT table_name, tablespace_name, partition_name, num_rows, high_value
FROM dba_tab_partitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name; 

col sales_no format 999
col sales_region format a5
col customer_id format 99999
col price format 99999
select * from scott.sales order by sales_no;

select * from scott.sales partition(SYS_P601) order by sales_no;


