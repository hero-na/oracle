set pause off 
prompt 
   
col res new_value block_size noprint 
select value res 
from v$parameter 
where name = 'db_block_size'; 
 
accept ownr char prompt 'Give owner  to display extents of: ' 
accept oname char prompt 'Give table name to display extents of: ' 
set verify off 
set feed off 
 
col tn format a10 heading 'Name' trunc 
col init format 9,999,999 heading 'Init Extent' 
col next format 9,999,999 heading 'Next Extent' 
col mi format 999 heading 'Min Extent' 
col ma format 9999999999 heading 'Max Extent' 
col pct format 990 heading 'PctInc' 
 
col s_init format a12 heading 'Init' 
col s_next format a12 heading 'Nxt to alloc' 
 
col sn format a15 heading 'Segment Name' 
col tn format a15 heading 'Tabspace/FileID' 
col st format a10 heading 'Type' 
col bytes format 999,999,999 
break on report  
compute sum of bytes blocks on report 
 
clear screen 
prompt Storage params for the tablespace the object is in: 
select distinct 
       d.tablespace_name tn,  
       initial_extent / &block_size || ' (' || initial_extent || ')' s_init,  
       next_extent / &block_size    || ' (' || next_extent    || ')' s_next,  
       pct_increase pct,  
       min_extents mi,  
       max_extents ma 
from sys.dba_tablespaces d, sys.dba_extents u 
where u.segment_name = upper('&oname') 
and   d.tablespace_name = u.tablespace_name 
and   u.owner = upper('&ownr'); 
 
prompt 
prompt Storage params for the segment the object is in: 
select distinct 
     s.segment_name sn,  
       t.initial_extent||' ('||t.initial_extent / &block_size||')' s_init,  
       t.next_extent||' ('||t.next_extent / &block_size||')' s_next,  
       t.pct_increase pct,  
       t.min_extents mi,  
       t.max_extents ma 
from sys.dba_segments s, sys.dba_tables t 
where s.segment_name = upper('&oname') 
and   s.owner = upper('&ownr') 
and   t.owner = upper('&ownr') 
and   t.table_name = s.segment_name(+); 
 
prompt 
prompt Overview of all the allocated extents in this segment: 
col st format a8 
col bts format 9999999 heading "Bytes" 
col bks format 9999    heading "Blocks" 
col bi  format 99999   heading "1st Blck" 
select extent_id, segment_name sn, segment_type st,  
       tablespace_name||'/'||file_id tn, 
       bytes bts, blocks bks, block_id bi 
from sys.dba_extents 
where segment_name = upper('&oname') 
and   owner = upper('&ownr') 
order by extent_id; 
/

