# African Cities
## Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
## GNote: CITY.CountryCode and COUNTRY.Code are matching key columns.

# FLOOR함수를 사용해서 내림
```
SELECT city.name
FROM city
    INNER JOIN country ON city.countrycode = country.code
WHERE country.continent = 'Africa'
```