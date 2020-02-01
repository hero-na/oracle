drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

create index oe.idx_object_id on oe.base_tb(object_id);

EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_OBJECT_ID');

select count(*) from oe.base_tb;

col segment_name format a15
set pagesize 100

select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='BASE_TB';

delete from oe.base_tb;
commit;
EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

select count(*) from oe.base_tb;
select segment_name, extent_id, block_id, blocks, bytes
from dba_extents
where segment_name='BASE_TB';

