--
-- アーカイブREDOログ使用量を確認
-- 前後でVALUE値を減算し、使用量を求める
--
col FILE_TYPE for A25
col PERCENT_SPACE_USED for 99.99
set heading off
set pages 0
set lines 2000
set feedback off
set trimspool on
set colsep |

select
       to_char(sysdate,'yyyy/mm/dd') "DATE",
       to_char(sysdate,'hh24:mi:ss') "TIME",
       to_char(sysdate,'yyyy/mm/dd hh24:mi') "SYSDT",
       FILE_TYPE ,
       PERCENT_SPACE_USED
  from v$recovery_area_usage
;
