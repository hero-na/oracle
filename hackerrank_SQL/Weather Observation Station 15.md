# Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to  decimal places.

* CEIL() 올림
  * 예: SELECT CEIL(5.5) => 6
* FLOOR() 내림
  * 예: SELECT FLOOR(5.5) => 5
* ROUND() 반올림
  * 예: ROUND(5.556901,4) => 5.5569


```
SELECT long_w, CEIL(LONG_W), FLOOR(LONG_W),ROUND(LONG_W,4) FROM station

```

# ORDER BY DESC 로 정렬후에 가장 높은 값 LIMIT 1 로 출력한다.

```
SELECT ROUND(LONG_W,4) -- Round 4 decimal places 4자리까지만 남기고 반올림
FROM station -- 테이블명
WHERE LAT_N < 137.2345 -- less than 137.2345
ORDER BY LAT_N DESC -- largest lat_n을 가진 데이터를 뽑기 위해 내림차순 정렬
LIMIT 1 -- 내림차순 정렬 중에 맨 위에걸 가져오면 largest lat_n