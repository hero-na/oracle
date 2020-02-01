col value format a105

SELECT value
FROM gv$parameter
WHERE name = 'control_files';

SELECT RPAD(SUBSTR(name, 1, 50), 51,' ') "CONTROL FILE NAME"
FROM gv$controlfile;
