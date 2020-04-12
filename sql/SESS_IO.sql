-- *********************************************************************
-- * V$SESS_IO
-- *   ユーザー・セッションごとのI/O 統計情報
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
