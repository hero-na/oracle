col status format 99999
col name format a10
select obj#, owner#, name, status, ctime, type# from sys.obj$ where obj#=92006;

