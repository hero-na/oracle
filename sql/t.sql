select table_name, GREATEST(4, ceil(num_rows /
((round(((8192 - (ini_trans * 23)) *
((100 - pct_used) /100)) / avg_row_len)))) *
8192)/1024/1024
TableSize_Mbytes
from dba_tables
where table_name='EMP_TEST';
