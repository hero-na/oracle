connect system/manager
col action format 9999
col action_name format a20
col username format a10

select action, action_name, username
from dba_audit_trail ;

