-- 
-- PKG性能(OP_FWN_POST_SAVE_PKG)
-- Sql_Name：infmon_check_pkg.sql
-- 
set lines 1100
set trimspool on
set heading off
set pages 0
set feedback off
set colsep |
--
select
       to_char(sysdate,'yyyy/mm/dd') "DATE",
       to_char(sysdate,'hh24:mi:ss') "TIME",
       to_char(sysdate,'yyyy/mm/dd hh24:mi') "SYSDT",
       old_hash_value,
       hash_value,
       sql_id,
       module,
       substr(sql_text,1,48) "sql_text",
       executions,
       elapsed_time,
       to_char(elapsed_time/executions/1000000,'99,999,990.99') "time"
  from v$sqlarea
 where lower(sql_text) like '%op_fwn_post_save_pkg%'
   and lower(sql_text) like '%postsaveproc%'
   and command_type = 47
;
