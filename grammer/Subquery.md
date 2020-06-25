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