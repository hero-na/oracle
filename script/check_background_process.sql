column paddr format a20
column name format a10
column description format a30

select  paddr, name, description
from v$bgprocess
where paddr <> '00'
order by paddr desc;

