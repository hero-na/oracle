drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

create index oe.idx_object_id on oe.base_tb(object_id);

EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_OBJECT_ID');

connect oe/oe 
col index_name format a20 
col used format a10
alter index oe.idx_object_id monitoring usage;
select index_name, used from v$object_usage;
set autotrace on
select count(*) from oe.base_tb where object_id=92333;
set autotrace off
select index_name, used 
from v$object_usage;
alter index oe.idx_object_id nomonitoring usage;
drop index oe.idx_object_id;
create index oe.idx_object_id on oe.base_tb(object_id);
alter index oe.idx_object_id monitoring usage;

select index_name, used 
from v$object_usage;

alter index oe.idx_object_id nomonitoring usage;
connect /as sysdba
