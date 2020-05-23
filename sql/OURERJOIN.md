* OUTER JOIN
  * 참고:SQL Joins Visualizer
  * INNER JOIN 외에는 OUTER JOIN
  * 왼쪽을 기준으로 할 때는 LEFT JOIN
  * 중복값많이 아닌 기준도 잡는다.
  * 기본적으로는 LEFT JOIN만을 이용한다.

```
SELECT Name
FROM Customers LEFT JOIN Orders ON Customers.Id = Orders.Id

SELECT c.Name as Customers
FROM Customers AS c
    LEFT JOIN Orders AS o ON c.Id = o.CustomerId
WHERE o.Id IS NULL

```