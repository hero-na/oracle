/*****************************************************************************
�y�X�N���v�g���z
check_free_space_all_csv.sql

�y�@�\�T�v�z
�ȉ��̍��ڂɂ��Ē��ׂ邱�Ƃ��ł���B
	�P�A�G�N�X�e���g�̎g�p��
	�Q�A�u���b�N�̎g�p��
	�R�A�̈�̎g�p��

�y�V�K�쐬�z
2000/11/30	: �O�c
�y�X�V�����z
2002/09/27	: ��c	ARBOR�̏�񂪎擾�ł���悤�ɏC��
2004/03/22	: ��	DWH(INFOAUD)�̏�񂪎擾�ł���悤�ɏC��
2006/02/07	: ����	�t�@�C���ɏo�͂����Ō���̃J���}���폜
2006/02/28	: ��	�擾�Ώۂ̃X�L�[�}����DCHECK���[�U���폜
2007/03/24	: ��	LOB�̏�񂪎擾�ł���悤�C��
2009/04/16	: ����	�p�[�e�B�V�����p�ɏC��

�y�g�p���@�z
SQL*Plus�ɂĎg�p�\�B
SQL*Plus��SYSTEM���[�U�Ń��O�C������K�v������B
�X�N���v�g���s��A�ufree_space_all.csv�v�Ƃ���CSV�t�@�C�����o�͂����B

�y�g�p��z
SQL> @check_free_space_all_csv.sql

*****************************************************************************/

set pagesize 0
set linesize 239
set colsep ','
set verify off
set feedback off
set pagesize 0
set newpage 0
set space 0
set serveroutput on
set trimspool on

-- SPOOL free_space_all.csv

-- �w�b�_�o��
PROMPT OWNER,SEGMENT_TYPE,TABLESPACE_NAME,SEGMENT_NAME,COUNT,MAX_EXTENTS,EXTENTS,TOTAL_BLOCKS,USED_BLOCKS,UNUSED_BLOCKS,TOTAL_BYTES,USED_BYTES,UNUSED_BYTES,PARTITION_NAME


DECLARE
	v_total_blocks		NUMBER;
	v_total_bytes		NUMBER;
	v_unused_blocks		NUMBER;
	v_unused_bytes		NUMBER;
	v_last_used_extent_file_id	NUMBER;
	v_last_used_extent_block_id	NUMBER;
	v_last_used_block	NUMBER;

	v_sql				VARCHAR2(10000);
	v_cur				INTEGER;
	v_rows				INTEGER;
	v_status			INTEGER;
	v_count				NUMBER;
	
	CURSOR selline IS
		 SELECT OWNER, SEGMENT_NAME,
			DECODE(SEGMENT_TYPE,'TABLE','TABLE','INDEX','INDEX','LOBSEGMENT','LOB','TABLE PARTITION','TABLE PARTITION','INDEX PARTITION','INDEX PARTITION') "SEGMENT_TYPE",
			TABLESPACE_NAME, NVL(PARTITION_NAME,'') PARTITION_NAME ,EXTENTS, MAX_EXTENTS
			FROM DBA_SEGMENTS
			WHERE OWNER in ( 'NANASHI', 'NTTIP', 'FILEDB', 'VANDB', 'INFOSYS', 'INFOSYS2','INFOAUD',
							 'SWBAPPS', 'ARBOR', 'FALLOC', 'FEUSER','BILL','COLLABO','VIW','LIP')
				AND SEGMENT_TYPE IN ('TABLE', 'INDEX','LOBSEGMENT','TABLE PARTITION','INDEX PARTITION')
--				AND PARTITION_NAME IS NOT NULL
			ORDER BY SEGMENT_TYPE, TABLESPACE_NAME, SEGMENT_NAME, PARTITION_NAME;
BEGIN
	DBMS_OUTPUT.ENABLE(1000000);

	FOR selrec IN selline LOOP


		-- �e�e�[�u���̗̈�g�p�󋵎擾
		DBMS_SPACE.UNUSED_SPACE(
			selrec.OWNER,
			selrec.SEGMENT_NAME,
			selrec.SEGMENT_TYPE,
			v_total_blocks,
			v_total_bytes,
			v_unused_blocks,
			v_unused_bytes,
			v_last_used_extent_file_id,
			v_last_used_extent_block_id,
			v_last_used_block,
			selrec.PARTITION_NAME
		);

		-- ���ʏo�́iCSV�`���j
		DBMS_OUTPUT.PUT_LINE(
			selrec.OWNER || ',' ||
			selrec.SEGMENT_TYPE || ',' ||
			selrec.TABLESPACE_NAME || ',' ||
			selrec.SEGMENT_NAME || ',' ||
			v_count || ',' ||
			selrec.MAX_EXTENTS || ',' ||
			selrec.EXTENTS || ',' ||
			v_total_blocks || ',' ||
			(v_total_blocks-v_unused_blocks) || ',' ||
			v_unused_blocks || ',' ||
			v_total_bytes || ',' ||
			(v_total_bytes-v_unused_bytes) || ',' ||
			v_unused_bytes || ',' ||
			selrec.PARTITION_NAME
		);
	END LOOP;

END;
/

SPOOL OFF

