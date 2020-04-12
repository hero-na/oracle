/*****************************************************************************
【スクリプト名】
check_free_space_all_csv.sql

【機能概要】
以下の項目について調べることができる。
	１、エクステントの使用状況
	２、ブロックの使用状況
	３、領域の使用状況

【新規作成】
2000/11/30	: 前田
【更新履歴】
2002/09/27	: 野田	ARBORの情報が取得できるように修正
2004/03/22	: 篠原	DWH(INFOAUD)の情報が取得できるように修正
2006/02/07	: 平川	ファイルに出力される最後尾のカンマを削除
2006/02/28	: 篠原	取得対象のスキーマからDCHECKユーザを削除
2007/03/24	: 篠原	LOBの情報が取得できるよう修正
2009/04/16	: 白井	パーティション用に修正

【使用方法】
SQL*Plusにて使用可能。
SQL*PlusにSYSTEMユーザでログインする必要がある。
スクリプト実行後、「free_space_all.csv」というCSVファイルが出力される。

【使用例】
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

-- ヘッダ出力
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


		-- 各テーブルの領域使用状況取得
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

		-- 結果出力（CSV形式）
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

