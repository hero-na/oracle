# Challenges


1. hacker_id별로 #challenges를 센다.

2. sorting #challenges desc

3. #challenges 가 max(#challenges)가 아니고 중복이 있다면 결과를 제외한다. hacker_id로 정렬을 해야한다.

4. 3.을 충족시키기위해 GROUP BY 아래에서 조건을 걸어서 실행해야한다.

```
-- hackers.hacker_id, hackers.name, challenges_created
-- sort challenges_created DESC, hacker_id
SELECT hackers.hacker_id
       , hackers.name
       , COUNT(*) challenges_created
FROM Challenges 
     INNER JOIN Hackers ON Challenges.hacker_id = Hackers.hacker_id
GROUP BY hackers.hacker_id, hackers.name
ORDER BY challenges_created DESC, hacker_id
```


```
SELECT MAX(challenges_created) FROM (
SELECT hacker_id
    , COUNT(*)
FROM Challenges
GROUP BY hacker_id ) sub
```

```
-- Answer
SELECT hackers.hacker_id
       , hackers.name
       , COUNT(*) challenges_created
FROM Challenges 
     INNER JOIN Hackers ON Challenges.hacker_id = Hackers.hacker_id
GROUP BY hackers.hacker_id, hackers.name
HAVING challenges_created = (SELECT MAX(challenges_created) 
                            FROM (
                                SELECT hacker_id
                                , COUNT(*) AS challenges_created
                                FROM Challenges
                                GROUP BY hacker_id ) sub)
ORDER BY challenges_created DESC, hacker_id
```

```
SELECT challenges_created, COUNT(*)
FROM (
SELECT hacker_id, COUNT(*) AS challenges_created 
FROM Challenges
GROUP BY hacker_id) sub
```


```
SELECT hackers.hacker_id
       , hackers.name
       , COUNT(*) challenges_created
FROM Challenges 
     INNER JOIN Hackers ON Challenges.hacker_id = Hackers.hacker_id
GROUP BY hackers.hacker_id, hackers.name
-- MAX(challenges_created), example 50
HAVING challenges_created = (SELECT MAX(challenges_created) 
                            FROM (
                                SELECT hacker_id
                                , COUNT(*) AS challenges_created
                                FROM Challenges
                                GROUP BY hacker_id ) sub)
OR Challenges_created IN ( SELECT challenges_created
                            FROM (
                                SELECT hacker_id
                                , COUNT(*) AS challenges_created 
                                FROM Challenges
                                GROUP BY hacker_id) sub
                                GROUP BY challenges_created
                                HAVING COUNT(*) = 1 )
ORDER BY challenges_created DESC, hacker_id
```

## WITH 를 쓰면 값을 저장 시킬 수 있다.

```
-- Answer
WITH counter AS(
    SELECT hackers.hacker_id
            ,hackers.name
            ,COUNT(*) AS challenges_created
    FROM Challenges
        INNER JOIN Hackers ON Challenges.hacker_id = Hackers.hacker_id
    GROUP BY hackers.hacker_id, hackers.name
)

SELECT counter.hacker_id
        , counter.name
        , counter.challenges_created
FROM counter
WHERE challenges_created = (SELECT MAX(challenges_created) FROM counter)
OR challenges_created IN (SELECT challenges_created
                         FROM counter
                         GROUP BY challenges_created
                         HAVING COUNT(*) = 1)
ORDER BY counter.challenges_created DESC, counter.hacker_id
```