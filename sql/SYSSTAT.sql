-- *********************************************************************
-- * V$SYSSTAT
-- *   �V�X�e�����v���
-- *********************************************************************
select
    sysdate     || ',' ||
    NAME        || ',' ||
    VALUE
  from
    V$SYSSTAT
;