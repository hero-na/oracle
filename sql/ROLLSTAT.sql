-- *********************************************************************
-- * V$ROLLSTAT
-- *   ���[���o�b�N�E�Z�O�����g�̓��v���
-- *********************************************************************
select
    sysdate           || ',' ||
--    VRS.INST_ID       || ',' ||
    DRS.SEGMENT_NAME  || ',' ||
    VRS.STATUS        || ',' ||
    VRS.EXTENTS       || ',' ||
    VRS.RSSIZE        || ',' ||
    VRS.WRITES        || ',' ||
    VRS.XACTS         || ',' ||
    VRS.GETS          || ',' ||
    VRS.WAITS         || ',' ||
    VRS.OPTSIZE       || ',' ||
    VRS.HWMSIZE       || ',' ||
    VRS.SHRINKS       || ',' ||
    VRS.WRAPS         || ',' ||
    VRS.EXTENDS       || ',' ||
    VRS.AVESHRINK     || ',' ||
    VRS.AVEACTIVE     || ',' ||
    VRS.CUREXT        || ',' ||
    VRS.CURBLK
  from
    DBA_ROLLBACK_SEGS DRS,
    V$ROLLSTAT        VRS
  where
    DRS.SEGMENT_ID = VRS.USN
;
