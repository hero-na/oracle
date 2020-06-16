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
```
일단 중복 제거
SELECT distinct Id,Email FROM Person ORDER BY Id desc LIMIT 5

SELECT * 
FROM crimes
WHERE date IN (SELECT distinct date FROM crimes ORDER BY date desc LIMIT 5);

```