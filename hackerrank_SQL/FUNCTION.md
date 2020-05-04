```
SELECT COUNT(*) FROM sample;
SELECT COUNT(name) FROM sample; -- NULL값을 빼고 출력
SELECT COUNT(DISTINCT name) FROM sample; -- 중복 값을 빼고 출력
```

* SUM
## 특정 칼럼에 대해서 계산을 하는 경우가 많다.

* AVG
```
SELECT AVG(visits) FROM sample; --- NULL을 빼고 계산할 경우
SELECT SUM(visits)/Count(*) FROM sample; --- NULL을 0으로 취급할 경우
```
* MIN
## 최소 값

* MAX
## 최대 값

* GROUP BY
```
SELECT SupplierID
     , Categoryid
     , AVG(price)
FROM products
GROUP BY SupplierID, Categoryid
ORDER BY AVG(price) DESC
```

* HAVING
```
SELECT SupplierID
     , Categoryid
     , AVG(price) AS avg_price
FROM products
GROUP BY SupplierID, Categoryid
HAVING avg_price >= 100
```