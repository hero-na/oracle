set linesize 200
set pagesize 0
set head off
set feedback off
set trimspool on
set echo off
set wrap off
set termout off
set serveroutput on
set verify off
set sqlcontinue off

select TO_CHAR(SYSDATE, 'yyyy/mm/dd,hh24:mi:ss') ||','||
(select trunc(value/1024/1024,0) from v$parameter where name = 'shared_pool_size') ||','||
(select trunc(BYTES/1024/1024,0) from V$SGASTAT where POOL='shared pool' and NAME='free memory') ||','||
(select trunc(value/1024/1024,0) from v$parameter where name = 'shared_pool_reserved_size') "SIZE,FREE_SIZE,REV_SIZE"
from dual;
