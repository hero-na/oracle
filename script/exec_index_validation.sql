drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

create index oe.idx_object_id on oe.base_tb(object_id);

EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_OBJECT_ID');

analyze index oe.idx_object_id validate structure;

col name format a15
col blocks format 99999
col distinct_keys format 999999
col del_lf_rows format 999999

select name, blocks, pct_used, distinct_keys lf_rows, del_lf_rows, (del_lf_rows/lf_rows_len) *100 
from index_stats;

set autotrace on
select object_name 
from oe.base_tb 
where object_id=92332;
set autotrace off

delete from oe.base_tb where object_id > 1 and object_id < 90000;
insert into oe.base_tb select * from oe.base_tb;
delete from oe.base_tb;
insert into  oe.base_tb select object_id, object_name, object_type from dba_objects;
delete from oe.base_tb where object_id > 1 and object_id < 90000;
--EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');
--EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_OBJECT_ID');


analyze index oe.idx_object_id validate structure;

select name, blocks, pct_used, distinct_keys lf_rows, del_lf_rows, (del_lf_rows/lf_rows_len) *100 
from index_stats;

set autotrace on
select object_name 
from oe.base_tb 
where object_id=92332;
set autotrace off

alter index oe.idx_object_id rebuild nologging parallel 2;

analyze index oe.idx_object_id validate structure;

select name, blocks, pct_used, distinct_keys lf_rows, del_lf_rows, (del_lf_rows/lf_rows_len) *100
from index_stats;

set autotrace on
select object_name 
from oe.base_tb 
where object_id=92332;
set autotrace off

