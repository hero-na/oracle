create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
create index oe.idx_object_id on oe.base_tb(object_id);
select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='BASE_TB';

select count(*) from oe.base_tb;
SELECT SUBSTR(object_name,1,10),substr(object_type,1,5),substr(owner,1,4)
FROM dba_objects
WHERE object_name LIKE '%RECYCLEBIN%';
select segment_name,tablespace_name from dba_segments
where segment_name ='BASE_TB';

select index_name,tablespace_name from dba_indexes
where index_name ='IDX_OBJECT_ID';

drop table oe.base_tb;
select object_name,ORIGINAL_NAME,ts_name from recyclebin;
SELECT object_name,original_name,operation,type,dropscn,droptime
FROM dba_recyclebin;
select segment_name,tablespace_name from dba_segments
where segment_name ='BASE_TB';

select index_name,tablespace_name from dba_indexes
where index_name ='IDX_OBJECT_ID';

purge table oe.base_tb;
select object_name,ORIGINAL_NAME,ts_name from recyclebin;
create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
drop table oe.base_tb purge;
select object_name,ORIGINAL_NAME,ts_name from recyclebin;
create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
drop table oe.base_tb purge;
select object_name,ORIGINAL_NAME,ts_name from recyclebin;
create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
drop table oe.base_tb;
select count(*) from oe.base_tb;
flashback table oe.base_tb to before drop;
select count(*) from oe.base_tb;


