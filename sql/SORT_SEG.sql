--********************************************************************
--**  Temporary表領域 (現状の使用状況)
--********************************************************************
--
TTITLE LEFT ' ■■■■■  現状の使用状況  ■■■■■ '
-- PROMPT SYSDATE,TABLESPACE_NAME,USED_BLOCKS,MAX_USED_BLOCKS
--
SELECT
       SYSDATE                               ||','||  
       TABLESPACE_NAME                       ||','||  
       USED_BLOCKS*8/1024                    ||','||  
       MAX_USED_BLOCKS*8/1024
  FROM
       V$SORT_SEGMENT
;
