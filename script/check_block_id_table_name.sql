select segment_name
from dba_extents
where file_id = &FILE_ID
and &&BLOCK_ID between block_id and block_id + blocks - 1
and rownum = 1
;

