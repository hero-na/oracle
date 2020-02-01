ACCEPT address PROMPT "Enter ADDR: "

COLUMN owner FORMAT A15
COLUMN object_name FORMAT A30
COLUMN subobject_name FORMAT A20

SELECT *
FROM   (SELECT o.owner,
               o.object_name,
               o.subobject_name,
               bh.tch,
               bh.obj,
               bh.file#,
               bh.dbablk,
               bh.class,
               bh.state
        FROM   x$bh bh,
               dba_objects o
        WHERE  o.data_object_id = bh.obj
        AND    hladdr = '&address'
        ORDER BY tch DESC)
WHERE  rownum < 11;

