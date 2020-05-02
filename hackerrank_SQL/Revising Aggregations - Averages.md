# Revising Aggregations - Averages
## Query the average population of all cities in CITY where District is California.

```
SELECT AVG(population) --population평균
FROM city --테이블명
WHERE district = 'California' --조건절
```

