-- *********************************************************************
-- * V$RESOURCE_LIMIT
-- *   �ꕔ�̃V�X�e���E���\�[�X�ł̃O���[�o���E���\�[�X�̎g�p�󋵂�
-- *   �ւ�����
-- *********************************************************************
select
    sysdate             || ',' ||
    RESOURCE_NAME       || ',' ||
    CURRENT_UTILIZATION || ',' ||
    MAX_UTILIZATION     || ',' ||
    INITIAL_ALLOCATION  || ',' ||
    LIMIT_VALUE
  from
    V$RESOURCE_LIMIT
;
