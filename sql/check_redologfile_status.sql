set line 200
col group# for 999
col mb for 9999
col member for a45
col seq# for 999
col status for a8
col arc for a5
 
select a.group#, a.member, b.bytes/1024/1024 MB, b.sequence# "SEQ#",
b.status, b.archived "ARC", b.first_change#
from v$logfile a, v$log b where a.group#=b.group# order by 1,2;
