/*****************************************************************************
【スクリプト名】
infmon_clear_work_table.sql
*****************************************************************************/

set trims on
set timing on
select * from global_name;
show user
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') "TRUNCATE_DATE" from dual;
select count(*) from MNGUSER.CHAINED_ROWS;
prompt TRUNCATE CHAINED_ROWS
truncate table MNGUSER.CHAINED_ROWS;
select count(*) from MNGUSER.CHAINED_ROWS;
set trims off
set timing off

