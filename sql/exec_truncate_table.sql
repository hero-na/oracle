drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

select count(*) from oe.base_tb;

col segment_name format a15
set pagesize 100

select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='BASE_TB';

truncate table oe.base_tb;
EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

select count(*) from oe.base_tb;
select segment_name, extent_id, block_id, blocks, bytes
from dba_extents
where segment_name='BASE_TB';

