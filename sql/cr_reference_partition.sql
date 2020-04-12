connect /as sysdba

DROP TABLE scott.sales_items PURGE;
DROP TABLE scott.sales PURGE;

DROP TABLESPACE SALES_TBS_1 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE SALES_TBS_2 INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE SALES_TBS_2 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs_01.dbf' size 20M autoextend on next 10M maxsize 100M;
CREATE TABLESPACE SALES_TBS_1 
DATAFILE '/u01/app/oracle/oradata/orcl/sales_tbs_02.dbf' size 20M autoextend on next 10M maxsize 100M;


create table scott.sales
( sale_id number(12) not null
, sale_date date not null
, sale_mode varchar2(8)
, sale_status varchar2(1)
)
partition by range (sale_date)
( partition p_before_jan_2016 values less than (to_date('01-JAN-2016','dd-MON-yyyy'))
, partition p_2016_jan values less than (to_date('01-FEB-2016','dd-MON-yyyy'))
, partition p_2016_feb values less than (to_date('01-MAR-2016','dd-MON-yyyy'))
, partition p_2016_mar values less than (to_date('01-APR-2016','dd-MON-yyyy'))
, partition p_2016_apr values less than (to_date('01-MAY-2016','dd-MON-yyyy'))
, partition p_2016_may values less than (to_date('01-JUN-2016','dd-MON-yyyy'))
, partition p_2016_jun values less than (to_date('01-JUL-2016','dd-MON-yyyy'))
, partition p_2016_jul values less than (to_date('01-AUG-2016','dd-MON-yyyy'))
, partition p_2016_aug values less than (to_date('01-SEP-2016','dd-MON-yyyy'))
, partition p_2016_sep values less than (to_date('01-OCT-2016','dd-MON-yyyy'))
, partition p_2016_oct values less than (to_date('01-NOV-2016','dd-MON-yyyy'))
, partition p_2016_nov values less than (to_date('01-DEC-2016','dd-MON-yyyy'))
, partition p_2016_dec values less than (to_date('01-JAN-2017','dd-MON-yyyy'))
) parallel;
alter table scott.sales add constraint sales_pk
primary key (sale_id); 

create table scott.sales_items
( sale_id number(12) not null
, product_id number not null
, quantity number not null
, sales_amount number not null
, constraint sales_items_sales_fk foreign key (sale_id)
references scott.sales(sale_id)
)
partition by reference (sales_items_sales_fk);



col table_name format a20
col tablespace_name format a20
col partition_name format a20
col num_rows format 99
col high_value format a30
set linesize 120
set pagesize 200
col partitioning_type format a20
col ref_ptn_constraint_name format a20
col ref_table format a20
col ref_ptn_constraint_name format a20


select table_name, partitioning_type, ref_ptn_constraint_name
from dba_part_tables
where table_name in ('SALES','SALES_ITEMS') and owner='SCOTT'; 

select dpt.table_name, dpt.partitioning_type, dc.table_name ref_table
from dba_part_tables dpt,
(select dcc.table_name, dcc.constraint_name from dba_constraints dc, dba_constraints dcc
where dc.constraint_name=dcc.constraint_name and dc.owner=dcc.owner) dc
where dpt.ref_ptn_constraint_name = dc.constraint_name(+)
and dpt.table_name in ('SALES','SALES_ITEMS') and dpt.owner='SCOTT';


select table_name, partition_name, high_value
from dba_tab_partitions
where table_name in ('SALES','SALES_ITEMS') and table_owner='SCOTT'
order by partition_position, table_name; 


col sale_id format 999
col sale_date format a20
col sale_mode format a10
col status format a10
col product_id format 999
col quantity format 999
col sales_amount format 99999


select * from scott.sales order by sale_id;

select * from scott.sales_items order by sale_id;

insert into scott.sales values (1, to_date('24-OCT-2016','dd-MON-yyyy'), 'auto', 'I') ;
insert into scott.sales values (2, to_date('25-OCT-2016','dd-MON-yyyy'), 'manual', 'P') ;
insert into scott.sales values (3, to_date('26-NOV-2016','dd-MON-yyyy'), 'manual', 'U') ;
insert into scott.sales_items values (1, 12, 40, 12000) ;
insert into scott.sales_items values (1, 2, 1, 2000) ;
insert into scott.sales_items values (2, 1, 4, 900) ;
insert into scott.sales_items values (2, 87, 4, 6200) ;
insert into scott.sales_items values (2, 2, 4, 3400) ;
insert into scott.sales_items values (3, 1, 90, 1200) ;
insert into scott.sales_items values (3, 90, 10, 9000) ;
insert into scott.sales_items values (3, 74, 12, 8000) ;
commit;

EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES');
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'SALES_ITEMS');

alter session set nls_date_format='dd-mon-yyyy' ;

select * from scott.sales order by sale_id;
select *
from scott.sales partition (p_2016_oct);
select *
from scott.sales partition (p_2016_nov);
select * from scott.sales_items order by sale_id;
select *
from scott.sales_items partition (p_2016_oct);
