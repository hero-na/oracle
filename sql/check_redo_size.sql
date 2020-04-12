--
-- REDOログ使用量を確認
-- 前後でVALUE値を減算し、使用量を求める
--
col NAME for A10
col VALUE for 9,999,999,999,990
set heading off
set pages 0
set lines 120
set feedback off
set trimspool on
set colsep |

select
       to_char(sysdate,'yyyy/mm/dd') "DATE",
       to_char(sysdate,'hh24:mi:ss') "TIME",
       to_char(sysdate,'yyyy/mm/dd hh24:mi') "SYSDT",
       STATISTIC# ,
       NAME ,
       CLASS ,
       VALUE ,
       STAT_ID
  from v$sysstat
 where name = 'redo size'
;
