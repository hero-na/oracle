* INNER JOIN
  * 관련성이 있는 두개 이상의 컬럼들을 이어 붙여서 정보를 추출한다.
  * INNER JOIN은 중복되는 값만을 출력한다.
  * 참고:SQL Joins Visualizer
  * ERD. 1대1 관계인지 다대다 관계인지를 생각해야 한다.

```
SELECT * FROM Users,Orders
WHERE Users.Id = Orders.userId
이 아니라
INNER JOIN ON 을 사용한다.

SELECT *
FROM Users
    INNER JOIN Orders ON Users.Id = Orders.userId


SELECT *
FROM Orders
    INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID

SELECT *
FROM Orders
    INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
    INNER JOIN Shippers ON Orders.SHipperId = Shippers.ShipperID
```