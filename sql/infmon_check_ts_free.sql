DOC
********************************************************************************
 [ファイル名]
    check_ts_free.sql
 [目的]       
    現在の各表領域の空き状況チェックし表示する。
 [項目]
   表領域名            ：監視するデータベースの表領域名。ローカル管理一時表領域は出力しません
   エクステント管理    ：表領域のエクステント管理方式  DICTIONARY  or  LOCAL
   ファイル数          ：表領域が構成されている物理ファイル数
   合計(MB)            ：表領域の容量
   使用容量(MB)        ：表領域内で既に使用（アロケート）されている容量
   空き断片数          ：連続している使用可能領域の数
   空き容量(MB)        ：表領域内の使用可能領域
   最大空断片サイズ(MB)：連続した未使用領域の中で最大のもの
   空き率(%)           ：表領域の容量に対する使用可能領域の比率を％で表示

 [対処]     
    表領域のサイズを拡張するか、必要以上に大きく領域確保されていないか調査する。
 [作成者]
 [作成日]
********************************************************************************
#
set echo      off
set linesize  120
set pagesize 1000
set trims     on
set head      on
clear col
ttitle off

col name                form a20            head "表領域名"
col EXTENTMANAGEMENT    form a10            head "エクステ|ント管理"
col FILE_COUNT          form       9,999    head "ファイル数"
col TOTAL               form 999,999,990.99 head "合計(MB)" 
col USED                form 999,999,990.99 head "使用容量(MB)"
col FREE_COUNT          form      99,999    head "空き|断片数"
col FREE_EXTENTS        form 999,999,990.99 head "空き容量(MB)"
col MAX_FREE            form     999,990.99 head "最大空断片|サイズ(MB)" 
col "Free(%)"           form         990.00 head "空き率|(%)"

--ttitle left '■■■■ 表領域の空き情報表示 ■■■■'
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
