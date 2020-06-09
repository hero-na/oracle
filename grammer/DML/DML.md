# DML은 Data Manipulation Language
1. INSERT
    테이블 전체에 데이터 추가하는 방법
    INSERT INTO 테이블명 VALUES(VALUE_LIST);
    -> 컬럼 순서대로 입력

    # 예시
    Salary
    Id,Name,Salary,Data

    INSERT INTO Salary VALUES('1','A','250','2020-03-31');

    값을 저장할 열 지정하기
    INSERT INTO 테이블명 (컬럼 리스트) VALUES (VALUE_LIST);

    INSERT INTO Salary(Id,Salary) VALUES('2','550');

2. UPDATE
    컬럼 전체에 데이터 업데이트
    UPDATE 테이블명 SET 컬럼 = 값;

    UPDATE Salary SET Sallary = Salary + 100;

    UPDATE 테이블명 SET 컬럼 = 값 WHERE 조건식;
    UPDATE Salary SET Sallary = Salary + 100 WHERE Id = 2;

3. DELETE
    테이블에서 전체에 데이터 삭제하고 싶을 때
    DELETE FROM 테이블명;

    DELETE FROM Salary;

    특정 행만 삭제하고 싶을 때.
    DELETE FROM 테이블명 WHERE  조건식;
    DELETE FROM Salary WHERE Id = 2 ;

