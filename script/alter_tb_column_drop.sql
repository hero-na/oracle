connect scott/tiger

DROP TABLE T1 PURGE;

CREATE TABLE t1 (
   pk NUMBER PRIMARY KEY,
   fk NUMBER,
   c1 NUMBER,
   c2 NUMBER,
   CONSTRAINT ri FOREIGN KEY (fk) REFERENCES t1,
   CONSTRAINT ck1 CHECK (pk > 0 and c1 > 0),
   CONSTRAINT ck2 CHECK (c2 > 0)
);

DESC t1;

ALTER TABLE t1 DROP (pk);

ALTER TABLE t1 DROP (c1);

ALTER TABLE t1 DROP (pk) CASCADE CONSTRAINTS;
DESC t1;

