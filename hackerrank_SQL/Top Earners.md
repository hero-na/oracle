# Top Earners
## We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.


* earnings = months x salary
* 각 earning 별로 몇 명이 그만큼 벌었는지 계산 (5000,2/30000,5/1000,1) GROUP BY
* earning중에 가장 큰 값을 가지고 온다. ORDER BY,LIMIT

```
SELECT months*salary AS earnings,COUNT(*)
FROM employee
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1
```