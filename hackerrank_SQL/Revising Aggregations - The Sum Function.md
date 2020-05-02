# Revising Aggregations - The Sum Function
## Query the total population of all cities in CITY where District is California.

```
SELECT SUM(population) -- population합계
FROM city -- 테이블명
WHERE district = 'California' -- 조건절
```