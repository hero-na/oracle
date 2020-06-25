# ERD란
Entity Relationship Diagram의 약자. (객체 관계 다이어그램)
- https://www.lucidchart.com/pages/er-diagrams#section_5
- 객체들간의 관계를 보기 위한 지도

# Entity(객체)
  - 각각의 테이블

# Attribute(칼럼정보)
  - Attribute의 특성을 나타내는 컬럼명
  - INT,Varchar데이터의 타입
    - PK, FK
      - PK(Primary Key)의 약자. 하나의 값을 갖는 유니크한 값.
      - FK(Forien Key)의 약자. 두가지 이상의 엔티티사이의 관계를 정의하는 값.
    - = 같은 표시가 One
    - 삼발이 같은 표시가 Many
      - ex) Orders - Order details
      -  One - Many
      - 이것을 화살표로 표현할 때, one은 짝대기 두개, many는 삼발이 같은 표시
# Relationship
   # Data type

   # 숫자
     - 정수 tinyind(),smallint(),mediumint(),int(),bigint()
     - 실수 decimal(),double(),float()

   # 문자 Varchar(),various character 의 약자/ char()
   # 날짜,시간
     - date() 1000-01-01 ~ 9999-12-31
     - datetime() 1000-01-01 00:00:00.000000 ~ 9999-12-31 23:59:59.999999
     - timestamp() datetime() + timezone
     - Orders 테이블에서 OrderDate는 왜 varchar()?
       - https://stackoverflow.com/questions/38677002/mysql-convert-string-to-datetime
     타임스탬프는 Datetime + Timezone 이 들어간다.
     컴퓨터는 datetime,timestamp를 문자형으로 이해하려고 한다.
     현업에서는 + 1개월을 하거나 연산을 할 때, 무조건 날짜와 관련 된 함수여야 한다. String -> datetype으로 변경하는 함수가 있다.
        - MySQL = str_to_date()
   # 날짜