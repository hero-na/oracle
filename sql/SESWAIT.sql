-- *********************************************************************
-- * V$SESSION_WAIT
-- *   �A�N�e�B�u�E�Z�b�V�������ҋ@���Ă��郊�\�[�X�܂��̓C�x���g
-- *********************************************************************
SELECT 
       sysdate           || ',' ||
       SID               || ',' ||
       SEQ#              || ',' ||
       EVENT             || ',' ||
       P1TEXT            || ',' ||
       P1                || ',' ||
       P1RAW             || ',' ||
       P2TEXT            || ',' ||
       P2                || ',' ||
       P2RAW             || ',' ||
       P3TEXT            || ',' ||
       P3                || ',' ||
       P3RAW             || ',' ||
       WAIT_CLASS_ID     || ',' ||
       WAIT_CLASS#       || ',' ||
       WAIT_CLASS        || ',' ||
       WAIT_TIME         || ',' ||
       SECONDS_IN_WAIT   || ',' ||
       STATE
  FROM
     V$SESSION_WAIT
;
