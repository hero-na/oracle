set linesize 200
column name format a50
column current_scn format a10
column checkpoint_change# format a10
select current_scn "Current SCN",checkpoint_change# "System Checkpoint SCN" from v$database;
select checkpoint_change# "System Checkpoint SCN" from v$database;
select name, checkpoint_change# "Datafile Checkpoint SCN" from v$datafile;
select name, checkpoint_change# "Start SCN" from v$datafile_header;
select name, last_change# "Stop SCN" from v$datafile;  
