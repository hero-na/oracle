```
SELECT CASE
            WHEN categoryid = 1 THEN '음료'
            WHEN categoryid = 2 THEN '조미료'
            ELSE '기타'
        END, *
FROM Products

SELECT CASE
            WHEN categoryid = 1 AND SupplierID = 1 THEN '음료'
            WHEN categoryid = 2 THEN '조미료'
            ELSE '기타'
        END, *
FROM Products

SELECT CASE
            WHEN categoryid = 1 AND SupplierID = 1 THEN '음료'
            WHEN categoryid = 2 THEN '소스'
            ELSE '이외'
        END AS categoryName, AVG(price)
FROM Products
GROUP BY categoryName

```