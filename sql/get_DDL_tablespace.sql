set heading off;
set echo off;
Set pages 999;
set long 90000; 
spool get_ddl_tablespace.log 
select dbms_metadata.get_ddl('TABLESPACE','TEMP') from dual;
spool off
