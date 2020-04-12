purge dba_recyclebin;
drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;
create index oe.idx_object_id on oe.base_tb(object_id);
EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');

col segment_name format a15
set pagesize 100

select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='BASE_TB';

select count(*) from oe.base_tb;

SELECT SUBSTR(object_name,1,10),substr(object_type,1,5),substr(owner,1,4)
FROM dba_objects
WHERE object_name LIKE '%RECYCLEBIN%';
col tablespace_name format a10
col index_name format a13

select segment_name,tablespace_name from dba_segments
where segment_name ='BASE_TB';

select index_name,tablespace_name from dba_indexes
where index_name ='IDX_OBJECT_ID';


drop table oe.base_tb;
set linesize 120

col table_name format a10
col object_name format a20
col original_name format a16
col ts_name format a10
col operation format a10
col type  format a10
col dropscn format 999999999 
col droptime format a20
col owner format a10

select count(*) from oe.base_tb;

select object_name,ORIGINAL_NAME,ts_name from dba_recyclebin;

SELECT object_name,original_name,operation,type,dropscn,droptime
FROM dba_recyclebin;

SELECT owner,original_name,operation,type FROM dba_recyclebin;

select segment_name,tablespace_name from dba_segments
where segment_name ='BASE_TB';

select index_name,tablespace_name from dba_indexes
where index_name ='IDX_OBJECT_ID';

purge table oe.base_tb;

SELECT owner,original_name,operation,type FROM dba_recyclebin;


create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

drop table oe.base_tb purge;

select object_name,ORIGINAL_NAME,ts_name from recyclebin;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

drop table oe.base_tb purge;

select object_name,ORIGINAL_NAME,ts_name from dba_recyclebin;












