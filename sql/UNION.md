# UNION은 중복된 값을 제거하고 보여준다.


```
SELECT *
FROM Products
WHERE price <= 10
OR price >= 200



UNION ALL을 사용하는 경우

SELECT *
FROM Products
WHERE price <=5

UNION

SELECT *
FROM Products
WHERE price >=200

※ 위의 경우는 UNION과UNION ALL의 결과 값이 같다.
  중복 값을 제거하고 보여준다.

※ CustomerID를 기준으로 정렬하는 경우. 주문정보는 있지만 고객정보는 없을 때, 혹은 그 반대의 경우.
  중복 값을 없이 표현해준다.

SELECT *
FROM Customers
     LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT *
FROM Customers
    RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

```