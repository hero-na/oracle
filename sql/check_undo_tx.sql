col name format a24 
col status format a24

select a.name, b.status
from v$rollname a, v$rollstat b
where a.name IN (select segment_name
		  from dba_segments
		  where tablespace_name = 'UNDOTBS1')
and a.usn = b.usn;

