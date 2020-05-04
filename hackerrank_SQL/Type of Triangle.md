# Type of Triangle
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.


```
SELECT CASE
            WHEN A = B AND B = C THEN 'Equilateral'
            ELSE 'ETC'
        END, A,B,C
FROM Triangles

SELECT CASE
            WHEN A = B AND B = C THEN 'Equilateral'
            WHEN A + B <= C OR A + C <= B OR B + C <= A  THEN 'Not A Triangle'
            WHEN A = B OR B = C OR A = C THEN 'Isosceles'
            ELSE 'Scalene'
        END
FROM Triangles

SELECT CASE WHEN categoryid = 1 THEN price ELSE NULL END AS category1_price,*
FROM products

# 카테고리별 평균을 구하는 경우(데이터 피벗팅)

SELECT AVG(CASE WHEN categoryid = 1 THEN price ELSE NULL END) AS category1_price
      ,AVG(CASE WHEN categoryid = 2 THEN price ELSE NULL END) AS category2_price
      ,AVG(CASE WHEN categoryid = 3 THEN price ELSE NULL END) AS category3_price
FROM products

```