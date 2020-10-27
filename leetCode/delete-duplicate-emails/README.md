[here](https://leetcode.com/problems/delete-duplicate-emails/)

---
중복되는 ID를 찾고, 그 중에 ID가 작은것 한개만을 출력해야 한다.
* DELETE가 필요 하다.
* 서브쿼리가 필요 하다.예)
```
SELECT daily_stats.week, AVG(daily_stats.incidents_daily)
FROM (
    SELECT week
    ,date
    ,COUNT(incident_id) AS incidents_daily
    FROM crimes
    GROUP BY week,date
)daily_stats
GROUP BY daily_stats.week
```
* 서브쿼리는 FROM,WHERE에 쓸 수 있다.
```
SELECT *
FROM crimes
WHERE date IN (SELECT date FROM crimes ORDER BY date DESC LIMIT 5);
```
* 보존해야하는 ID를 가지고 온다.
```
SELECT Email,MIN(Id) FROM Person 
GROUP BY Email
```


