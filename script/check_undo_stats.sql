-- To list all Undo datafiles with status and size
show parameter undo
col tablespace_name form a10
col file_name form a45
col status format a10
set lines 120

select tablespace_name, file_name, status, bytes/1024/1024 from dba_data_files
where tablespace_name=(select tablespace_name from dba_tablespaces where contents='UNDO');

set linesize 152  
col tablespace_name for a20
col status for a10

-- Extent Count and Total Blocks
select tablespace_name,status,count(extent_id) "Extent Count",
sum(blocks) "Total Blocks",sum(bytes)/(1024*1024*1024) spaceInGB
from   dba_undo_extents
where  tablespace_name in ('UNDOTBS1')
group by  tablespace_name,status;


-- To check for Active Transactions
col usn format 999 
col extents format 999
col rssize format 999
col hwmsize format 99999
set head on
select usn,extents,round(rssize/1048576)
rssize,hwmsize,xacts,waits,optsize/1048576 optsize,shrinks,wraps
from v$rollstat where xacts>0
order by rssize;


