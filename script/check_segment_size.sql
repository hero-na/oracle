col segment_name for a15
col tablspace_name for a10

select segment_name, round(initial_extent/1024,0) ini_kb,
       round(next_extent/1024,0) nxt_kb,
       round(bytes/1024,0) tot_kb,
       pct_increase pct, extents, tablespace_name
from dba_segments
where segment_type ='TABLE' and extents >= nvl(&extent_num,1) ;
