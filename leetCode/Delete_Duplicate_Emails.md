# 196. Delete Duplicate Emails

# Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

# ID가 작은것을 하나만. 중복이 되는 이메일중에서 스몰리스트 이메일이 아닌것들을 삭제하면 된다. 중복제거를 하되 가장 작은 아이디를 가진 값을 출력한다.

# 일단 중복 제거
```
SELECT distinct Id,Email FROM Person ORDER BY Email desc LIMIT 5
```
# 가장 작은 Id를 찾는다.
# DELETE를 활용하여 서브쿼르로 값을 구한다
```
DELETE
FROM person
WHERE Id NOT IN(
SELECT sub.min_id
FROM (
SELECT Email,MIN(Id) as min_id
FROM Person
GROUP BY Email
) sub)
```

# 서브쿼리 예제
```
SELECT *
FROM Person
WHERE Id IN (
SELECT distinct Email FROM Person ORDER BY Email desc )

SELECT *
FROM crimes
WHERE date IN (SELECT distinct date FROM crimes ORDER BY date desc LIMIT 5);
```

# DELETE에 JOIN활용하기
조인 이후에도 특정 테이블의 값을 지정해서 삭제 할 수 있다.

```
DELETE t1,t2
FROM t1
INNER JOIN t2 ON t1.id = t2.ref
WHERE t1.id = 1;
```
# 셀프 조인을 활용해서 중복되는 값을 지우는 것이 가능하다.
```
SELECT *
FROM
Person p1
    INNER JOIN Person p2 ON p1.Email = p2.Email

```
# 결과
p1.Id. p1.Email. p2.Id. p2.Email

# 이 문제는 DELETE를 사용해야 한다.
```
DELETE p1
FROM 
Person p1
    INNER JOIN Person p2 ON p1.Email = p2.Email
WHERE p1.Id > p2.Id

```
