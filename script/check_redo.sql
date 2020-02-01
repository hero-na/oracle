column first_change# format 999999999999999
column member format a40
column status format a20
column sequence# format 999
set linesize 100
select a.first_change#, a.status, b.member,a.sequence#
from   v$log a, v$logfile b
where  a.group#=b.group#;

