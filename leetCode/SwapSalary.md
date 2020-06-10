# Given a table salary, such as the one below, that has m=male and f=female values. Swap all f and m values (i.e., change all f values to m and vice versa) with a single update statement and no intermediate temp table. Note that you must write a single update statement, DO NOT write any select statement for this problem.



Example:

| id  | name | sex | salary |
| --- | ---- | --- | ------ |
| 1   | A    | m   | 2500   |
| 2   | B    | f   | 1500   |
| 3   | C    | m   | 5500   |
| 4   | D    | f   | 500    |
After running your update statement, the above salary table should have the following rows:
| id  | name | sex | salary |
| --- | ---- | --- | ------ |
| 1   | A    | f   | 2500   |
| 2   | B    | m   | 1500   |
| 3   | C    | f   | 5500   |
| 4   | D    | m   | 500    |


'''
UPDATE 테이블명
  SET 컬럼명 = CASE
                WHEN condition1 THEN value_if_condition1_true
                WHEN condition1 THEN value_if_condition1_true
              ELSE value_other_case
              END
              (WHERE 조건식);
'''

# 조건에 따라 업데이트를 해야 한다.

'''
UPDATE salary
  SET sex = CASE WHEN sex = 'f' THEN 'm'
      ELSE 'f' END;
'''

'''
UPDATE Salary
  SET Name = CASE
                WHEN Id = 1 THEN '가'
                WHEN Id = 2 THEN '나'
                WHEN Id = 3 THEN '다'
                WHEN Id = 4 THEN '랴'
                WHEN Id = 5 THEN '마'
              ELSE '확인필요'
              END;
'''