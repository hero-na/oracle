connect system/manager
create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
select count(*) from oe.base_tb;
select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='BASE_TB';
delete from oe.base_tb;
commit;

select count(*) from oe.base_tb;
select segment_name, extent_id, block_id, blocks, bytes
from dba_extents
where segment_name='BASE_TB';

