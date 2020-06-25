# Subquery
# 쿼리 안에 들어가는 또다른 쿼리

# FROM 절 서브쿼리 - 가상의 테이블을 하나 더 만든다.
```
SELECT daily_stats.week
,AVG(daily_stats.incidents_daily)
FROM(
    SELECT week
    ,date
    ,COUNT(incident_id) AS incidents_daily
    FROM crimes
    GROUP BY week, date
    )daily_stats
)
GEOUP BY daily_stats.week

```

# 결과
week , date 의 결과가 나오게 된다.

# WHERE 절 서브쿼리

```
#  서브쿼리의 결과가 하나가 나와야 한다.
SELECT *
FROM crimes
WHERE date = (SELECT MIN(date) FROM crimes)

#  서브쿼리의 결과가 복수로 나올 때 IN을 사용가능하다.
SELECT *
FROM crimes
WHERE DATE IN (SELECT date FROM crimes ORDER BY date DESC LIMIT 5)
```