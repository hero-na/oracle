drop table oe.tb_stat purge;
create table oe.tb_stat  
       (stat_id number(10),
        stat_num number(10),
        stat_name varchar2(20));


begin
    for i in 1001 .. 5000 loop
    insert into oe.tb_stat  values ( i , i , 'statname');
    end loop ;
    end ;
     /

select count(*) from oe.tb_stat purge;

col num_rows format 999999
col blocks format 99999
col empty_blocks format 9999
col avg_space format 9999
col avg_row_len format 9999
set linesize 120
set pagesize 100
select num_rows
      , blocks
      , empty_blocks
      , avg_space
      , avg_row_len
      , last_analyzed
from  dba_tables
where owner = 'OE'
and   table_name = 'TB_STAT';

EXEC DBMS_STATS.gather_table_stats('OE', 'TB_STAT');
select count(*) from oe.tb_stat;

select num_rows
      , blocks
      , empty_blocks
      , avg_space
      , avg_row_len
      , last_analyzed
from  dba_tables
where owner = 'OE'
and   table_name = 'TB_STAT';




 
