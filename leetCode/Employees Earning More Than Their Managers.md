# 181. Employees Earning More Than Their Managers
```
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+
```

```
SELECT Employee.Name AS employee_name
      ,Employee.Salary AS employee_salary
      ,Manager.Name AS manager_name
      ,Manager.Salary AS manager_salary
FROM Employee
     INNER JOIN Employee as Manager ON Employee.ManagerId = Manager.id
WHERE Employee.Salary > Manager.Salary

SELECT Employee.Name AS Employee
FROM Employee
     INNER JOIN Employee as Manager ON Employee.ManagerId = Manager.id
WHERE Employee.Salary > Manager.Salary

SELECT Employee.Name AS Employee
FROM Employee
    INNER JOIN Employee as Manager ON Employee.managerid = Manager.id
WHERE Employee.Salary > Manager.Salary

```


# 191. Rising Temperature
###
```
```