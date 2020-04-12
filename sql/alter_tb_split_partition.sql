connect /as sysdba
set pagesize 200
col table_name format a10
col partition_name format a20
col num_rows format 99999
exec dbms_stats.gather_table_stats('SH','SALES');
select table_name,partition_name,num_rows
from dba_tab_partitions
where table_name = 'SALES';
ALTER TABLE sh.sales SPLIT PARTITION SALES_Q1_2002 INTO (
 PARTITION SALES_JAN_2002 VALUES LESS THAN (TO_DATE('01-FEB-2002','DD-MON-YYYY')),
 PARTITION SALES_FEB_2002 VALUES LESS THAN (TO_DATE('01-MAR-2002','DD-MON-YYYY')),
 PARTITION SALES_MAR_2002);

exec dbms_stats.gather_table_stats('SH','SALES');
select table_name,partition_name,num_rows
from dba_tab_partitions
where table_name = 'SALES';

ALTER TABLE sh.sales 
   MERGE PARTITIONS SALES_JAN_2002, SALES_FEB_2002, SALES_MAR_2002
   INTO PARTITION SALES_Q1_2002;

select table_name,partition_name,num_rows
from dba_tab_partitions
where table_name = 'SALES';

