-- *********************************************************************
-- * V$FILESTAT
-- *   �t�@�C���̓Ǎ���/ �����݂̓��v���
-- *********************************************************************
select
    sysdate         || ',' ||
    DF.FILE_NAME    || ',' ||
    FS.PHYRDS       || ',' ||
    FS.PHYWRTS      || ',' ||
    FS.PHYBLKRD     || ',' ||
    FS.PHYBLKWRT    || ',' ||
    FS.READTIM      || ',' ||
    FS.WRITETIM     || ',' ||
    FS.AVGIOTIM     || ',' ||
    FS.LSTIOTIM     || ',' ||
    FS.MINIOTIM     || ',' ||
    FS.MAXIOWTM     || ',' ||
    FS.MAXIORTM
  from
    V$FILESTAT      FS,
    DBA_DATA_FILES  DF
  where
    DF.FILE_ID = FS.FILE#
;
