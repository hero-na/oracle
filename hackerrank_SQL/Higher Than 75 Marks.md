# Higher Than 75 Marks

## MySQL의 함수를 사용해야한다.
## LEFT(컬럼명 또는 문자열, 문자열의 길이)
### 예:SELECT LEFT("20140323",4) => 2014
## RIGHT(컬ㄹ럼명 또는 문자열, 문자열의 길이)
### 예:SELECT RIGHT("20140323",4) => 0323
## SUBSTRING(컬럼명 또는 문자열, 시작위치,길이)
### = SUBSTR()
### 예: SUBSTR("20140323",1,4) =>2014
### 예: SUBSTR("20140323",5) => 0323

---

#### 첫 번째 정렬기준 name컬럼의 마지막 3글자, 두번째 정렬기준 id

```SELECT name
FROM students
WHERE marks > 75
ORDER BY RIGHT(name,3),id