/*****************************************************************************
【スクリプト名】
infmon_analyze_table_csv.sql
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
set trims on

-- ヘッダ出力
PROMPT TABLE_NAME,CHAIN_CNT,NUM_ROWS


DECLARE
    v_sql           VARCHAR2(1000);
    v_cur           INTEGER;
    v_rows          INTEGER;
    v_status        INTEGER;
    v_count         NUMBER;

    CURSOR selline IS
        SELECT OWNER_NAME, TABLE_NAME, COUNT(HEAD_ROWID) CNT_HEAD_ROWID
            FROM MNGUSER.CHAINED_ROWS
            GROUP BY OWNER_NAME, TABLE_NAME;
BEGIN
    DBMS_OUTPUT.ENABLE(1000000);

    FOR selrec IN selline LOOP

         -- 各テーブルの件数取得
         v_sql := 'SELECT COUNT(*) FROM ' || selrec.OWNER_NAME || '.' || selrec.TABLE_NAME;
         v_cur := DBMS_SQL.OPEN_CURSOR;
         DBMS_SQL.PARSE(v_cur, v_sql, DBMS_SQL.v7);
         DBMS_SQL.DEFINE_COLUMN(v_cur, 1, v_count);
         v_rows := DBMS_SQL.EXECUTE(v_cur);
         v_status := DBMS_SQL.FETCH_ROWS(v_cur);
         IF v_status <> 0 THEN
             DBMS_SQL.COLUMN_VALUE(v_cur, 1, v_count);
         END IF;
         DBMS_SQL.CLOSE_CURSOR(v_cur);

        -- 結果出力（CSV形式）
        DBMS_OUTPUT.PUT_LINE(
            selrec.TABLE_NAME || ',' ||
            selrec.CNT_HEAD_ROWID || ',' ||
            v_count
        );
    END LOOP;

END;
/

