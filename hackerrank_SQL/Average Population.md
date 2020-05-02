# Average Population
## Query the average population for all cities in CITY, rounded down to the nearest integer.

# FLOOR함수를 사용해서 내림
```
SELECT FLOOR(AVG(population))
FROM city

```