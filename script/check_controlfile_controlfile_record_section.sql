column type format a30 
set linesize 120

select type,record_size,records_total,records_used
from v$controlfile_record_section;

