-- *********************************************************************
-- * V$SESS_IO
-- *   ���[�U�[�E�Z�b�V�������Ƃ�I/O ���v���
-- *********************************************************************
select
    sysdate             || ',' ||
--    INST_ID             || ',' ||
    SID                 || ',' ||
    BLOCK_GETS          || ',' ||
    CONSISTENT_GETS     || ',' ||
    PHYSICAL_READS      || ',' ||
    BLOCK_CHANGES       || ',' ||
    CONSISTENT_CHANGES
  from
    V$SESS_IO
;
