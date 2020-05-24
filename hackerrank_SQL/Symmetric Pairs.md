# Symmetric Pairs

```
You are given a table, Functions, containing two columns: X and Y.



Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X.

Sample Input



Sample Output

20 20
20 21
22 23
```
```
SELECT X,Y,COUNT(*)
FROM Functions
WHERE X = Y
GROUP BY X,Y

# X,Y가 같은 경우
SELECT X,Y
FROM Functions
WHERE X = Y
GROUP BY X,Y
HAVING COUNT(*) = 2

# X,Y가 다른 경우도 찾아야 한다. SELF JOIN을 이용한다.
SELECT f1.X,f1.Y,f2.X,f2.Y
FROM Functions AS f1
    INNER JOIN functions AS f2 ON f1.X = f2.Y AND f1.Y = f2.X


SELECT f1.X,f1.Y,f2.X,f2.Y
FROM Functions AS f1
    INNER JOIN functions AS f2 ON f1.X = f2.Y AND f1.Y = f2.X
WEHERE f1.X < f1.Y

SELECT f1.X,f1.Y,f2.X,f2.Y
FROM Functions AS f1
    INNER JOIN functions AS f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X < f1.Y
ORDER BY x

# X=Y, X<Y의 두개의 쿼리를 UNION 해서 결과를 출력
SELECT X,Y
FROM Functions
WHERE X = Y
GROUP BY X,Y
HAVING COUNT(*) = 2

UNION

SELECT f1.X,f1.Y
FROM Functions AS f1
    INNER JOIN functions AS f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X < f1.Y
ORDER BY X

#UNION이 끝나고 난 후에 ORDER BY를 쓸 수 있다.
```

