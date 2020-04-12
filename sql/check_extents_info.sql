col segment_name format a15
set pagesize 100
select segment_name, extent_id, block_id, blocks, bytes 
from dba_extents 
where segment_name='CUST_LNAME_IX';
