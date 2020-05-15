* OUTER JOIN
  * 참고:SQL Joins Visualizer
  * INNER JOIN 외에는 OUTER JOIN
  * 왼쪽을 기준으로 할 때는 LEFT JOIN
  * 중복값많이 아닌 기준도 잡는다.

```
SELECT * 
FROM Users LEFT JOIN Orders ON Users.Id = Orders.userId



```