col owner format a10
col segment_name format a20
col segment_type format a10
select owner, segment_name, segment_type, bytes/1024/1024 MB,
INITIAL_EXTENT,NEXT_EXTENT,PCT_INCREASE from dba_segments
where segment_name=upper('&seg_name');
