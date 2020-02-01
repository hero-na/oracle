set linesize 200
set pagesize 300

col segment_name format a20
col blocks format 99999999999999
col empty_blocks format 99999999999999


select BLOCKS "Blk below HWM" 
from dba_segments 
where segment_name='CUSTOMERS' and owner ='OE';

select blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='CUSTOMERS' and owner='OE';

