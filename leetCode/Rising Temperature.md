# 197. Rising Temperature
```
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+
```

## self join
###  어제와 오늘을 비교하기위해 id의 조인키에 +1을 해준다.
### id를 기준으로 할시 예외처리가 불가능하다.
### 날짜를 기준으로 해야한다.

```
SELECT Weather.Id AS Weather
FROM Weather

SELECT Weather.Id AS Id
FROM Weather
 INNER JOIN Weather as today ON Weather.Id = today.id
WHERE Weather.Temperature > today.Temperature

SELECT today.id
FROM WEATHER AS today
    INNER JOIN Weather AS yesterday ON yesterday.id + 1 = today.id

SELECT today.id AS today_id
FROM WEATHER AS today
    INNER JOIN Weather AS yesterday ON yesterday.id + 1 = today.id

SELECT today.id AS Id
FROM WEATHER AS today
    INNER JOIN Weather AS yesterday ON yesterday.id + 1 = today.id
WHERE today.Temperature > yesterday.Temperature

SELECT today.id AS Id
FROM WEATHER AS today
    INNER JOIN Weather AS yesterday ON yesterday.RecordDate + 1 = today.RecordDate
WHERE today.Temperature > yesterday.Temperature

시간 더하기
DATE_ADD(기준 날짜, INTERVAL)
DATE_ADD(NOW(), INTERVAL 1 SECOND)
DATE_ADD(NOW(), INTERVAL -1 SECOND)
DATE_ADD(NOW(), INTERVAL 1 YEAR)
DATE_ADD(NOW(), INTERVAL 1 MONTH)
DATE_ADD(NOW(), INTERVAL 1 DAY)
DATE_ADD(NOW(), INTERVAL 1 MINUTES)

시간 빼기
DATE_SUB(기준 날짜, INTERVAL)


self join은 alias를 주는것이 포인트.
답:

SELECT today.id AS Id
FROM WEATHER AS today
    INNER JOIN Weather AS yesterday ON DATE_ADD(yesterday.RecordDate, INTERVAL 1 DAY) = today.RecordDate
WHERE today.Temperature > yesterday.Temperature

```