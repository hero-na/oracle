col tablespace_name for a15
select tablespace_name, extent_id, blocks, bytes
from dba_extents
where segment_name = 'CUST_LNAME_IX';

