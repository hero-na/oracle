--********************************************************************
--**  Temporary�\�̈� (����̎g�p��)
--********************************************************************
--
TTITLE LEFT ' ����������  ����̎g�p��  ���������� '
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
