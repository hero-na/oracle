DOC
********************************************************************************
 [�t�@�C����]
    check_ts_free.sql
 [�ړI]       
    ���݂̊e�\�̈�̋󂫏󋵃`�F�b�N���\������B
 [����]
   �\�̈於            �F�Ď�����f�[�^�x�[�X�̕\�̈於�B���[�J���Ǘ��ꎞ�\�̈�͏o�͂��܂���
   �G�N�X�e���g�Ǘ�    �F�\�̈�̃G�N�X�e���g�Ǘ�����  DICTIONARY  or  LOCAL
   �t�@�C����          �F�\�̈悪�\������Ă��镨���t�@�C����
   ���v(MB)            �F�\�̈�̗e��
   �g�p�e��(MB)        �F�\�̈���Ŋ��Ɏg�p�i�A���P�[�g�j����Ă���e��
   �󂫒f�А�          �F�A�����Ă���g�p�\�̈�̐�
   �󂫗e��(MB)        �F�\�̈���̎g�p�\�̈�
   �ő��f�ЃT�C�Y(MB)�F�A���������g�p�̈�̒��ōő�̂���
   �󂫗�(%)           �F�\�̈�̗e�ʂɑ΂���g�p�\�̈�̔䗦�����ŕ\��

 [�Ώ�]     
    �\�̈�̃T�C�Y���g�����邩�A�K�v�ȏ�ɑ傫���̈�m�ۂ���Ă��Ȃ�����������B
 [�쐬��]
 [�쐬��]
********************************************************************************
#
set echo      off
set linesize  120
set pagesize 1000
set trims     on
set head      on
clear col
ttitle off

col name                form a20            head "�\�̈於"
col EXTENTMANAGEMENT    form a10            head "�G�N�X�e|���g�Ǘ�"
col FILE_COUNT          form       9,999    head "�t�@�C����"
col TOTAL               form 999,999,990.99 head "���v(MB)" 
col USED                form 999,999,990.99 head "�g�p�e��(MB)"
col FREE_COUNT          form      99,999    head "��|�f�А�"
col FREE_EXTENTS        form 999,999,990.99 head "�󂫗e��(MB)"
col MAX_FREE            form     999,990.99 head "�ő��f��|�T�C�Y(MB)" 
col "Free(%)"           form         990.00 head "�󂫗�|(%)"

--ttitle left '�������� �\�̈�̋󂫏��\�� ��������'
select
  ts.name,
  decode(ts.bitmapped, 0, 'DICTIONARY', 'LOCAL')               EXTENTMANAGEMENT,
  df.file_count                                                FILE_COUNT,
  df.total_bytes/(1024*1024)                                   TOTAL,
  nvl(fs.free_count,0)                                         FREE_COUNT,
  ((df.total_bytes) - nvl(fs.free_extents,0))/(1024*1024)      USED,
  nvl(fs.free_extents,0)/(1024*1024)                           FREE_EXTENTS,
  nvl(fs.max_free,0)/(1024*1024)                               MAX_FREE,
  trunc((nvl(fs.free_extents,0)/df.total_bytes)*100,2)        "FREE(%)" 
from
  sys.ts$ ts,
  (select 
     tablespace_name,
     count(user_bytes)    FILE_COUNT,
     sum(user_bytes)      TOTAL_BYTES
   from
   dba_data_files 
   group by tablespace_name
  ) df, 
  (select
     tablespace_name,
     count(fs.bytes) FREE_COUNT,
     sum(fs.bytes)   FREE_EXTENTS,
     max(fs.bytes)   MAX_FREE
   from 
      dba_free_space fs
   group by tablespace_name
   ) fs
where 
  ts.name = fs.tablespace_name(+) and
  ts.name = df.tablespace_name    and
  df.file_count !=0 
--order by 9,1 
;
clear col
ttitle off
set echo on
