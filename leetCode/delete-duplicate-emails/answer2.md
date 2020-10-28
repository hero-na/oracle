[here](https://leetcode.com/problems/delete-duplicate-emails/)

---
* DELETE에JOIN을 활용한다.

```
DLETE t1,t2
FROM t1
INNER JOIN t2 ON t1.id = t2.ref
WHERE t1.id = 1;
```
- INNER JOIN을 하고 t1,t2에서 나오는 데이터를 삭제한다.
- JOIN 이후에도 특정 테이블의 데이터가 삭제되도록 테이블명을 명시해야 한다.

* 테이블이 하나인 경우 셀프 조인을 활용한다.
```
DELETE p1,p2 
SELECT Id
FROM Person p1
INNER JOIN Person p2 ON p1.Email = pe.Email
```