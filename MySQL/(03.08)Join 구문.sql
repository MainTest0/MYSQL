

CREATE DATABASE shopdb;
USE shopdb;

-- 카멜 로테이션 기법
-- 구매 회원 정보
CREATE TABLE userTBL(
	userName CHAR(3) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile CHAR(10) NOT NULL,
    PRIMARY KEY(userName)
);

-- 테이블 구조 수정
ALTER TABLE userTBL MODIFY mobile VARCHAR(13);

-- 사용자의 구매이력 테이블
CREATE TABLE buyTBL(
	userName CHAR(3) NOT NULL,
    prodName CHAR(3) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY(userName) REFERENCES userTBL(userName)
);

insert into userTBL values('이승기', 1987, '서울', '010-1234-1234');
insert into userTBL values('홍길동', 1911, '부산', '010-2222-3333');
insert into userTBL values('이순신', 1999, '대구', '010-3333-4444');

insert into buyTBL values('이승기', '운동화', 50, 1);
insert into buyTBL values('이승기', '노트북', 150, 1);
insert into buyTBL values('홍길동', '책', 10, 5);
insert into buyTBL values('홍길동', '모니터', 200, 2);
insert into buyTBL values('이순신', '청바지', 40, 1);
insert into buyTBL values('이순신', '책', 10, 3);

-- ERROR CODE 1452 : 부모 테이블에 야스오라는 사람이 없어서 난 에러
-- 부모 테이블 userTBL에 야스오는 없는 사람이기 때문에 존재할 수 없다.
insert into buyTBL values('야스오', '책', 10, 3);

SELECT * FROM userTBL;
SELECT * FROM buyTBL;

-- inner join
SELECT *
FROM userTbl
INNER JOIN buyTBL
ON userTBL.userName = buyTBL.userName;	-- user와 buy 테이블의 name을 기준으로 join하기

-- left join
SELECT *
FROM userTBL
LEFT JOIN buyTBL
ON userTBL.userName = buyTBL.userName;

-- 야스오 회원 가입함
INSERT INTO userTBL(userName, birthYear, addr, mobile)
VALUES ('야스오', 2020, '부산', '010-1234-1234');

SELECT *
FROM userTBL
LEFT JOIN buyTBL
ON userTBL.userName = buyTBL.userName
WHERE buyTBL.userName IS NOT NULL;

-- AS(별칭) 사용해서 다시 inner join

SELECT *
FROM userTBL AS U
INNER JOIN buyTBL AS B -- 별칭
ON U.userName = B.userName;

-- 별칭 사용 left join, left join is not null 작성해보기
SELECT *
FROM userTBL as A
LEFT JOIN buyTBL as C
ON A.userName = C.userName
WHERE C.userName IS NOT NULL;

-- left join 기준 테이블 선정
-- 지금까지 기준을 user로 지정했음 buy로 바꿔보기
-- 기준 테이블 선정에 따라 결과집합이 다를 수 있다.
-- 기준 테이블 선정 기준은 작은 데이터를 기준으로 하는 것이 좋다.
SELECT *
FROM buyTBL AS b
LEFT JOIN userTBL AS u
ON b.userName = u.userName;

-- right join
SELECT u.userName, b.prodName, b.price, b.amount
FROM userTBL AS u
RIGHT JOIN buyTBL AS b
ON u.userName = b.userName;

-- 테이블이 없어도 동작한다.
SELECT u.userName, b.prodName, b.price, b.amount,
	(b.price * b.amount) AS 'SUM'
FROM userTBL AS u
RIGHT JOIN buyTBL AS b
ON u.userName = b.userName;

-- 문제 작성 3문제

-- 1. userName을 기준으로해서 LEFT JOIN 만들어보기
-- 	  (WHERE 구문으로 NULL값은 빼기)
SELECT *
FROM userTBL AS u
LEFT JOIN buyTBL AS b
ON u.userName = b.userName
WHERE b.userName IS NOT NULl;

-- 2. buyName을 기준으로해서 RIGHT JOIN 만들어보기(name, addr, mobile, price, amount만 출력)
SELECT u.userName, u.addr, u.mobile,
		b.price, b.amount, (b.price * b.amount) AS '총 구입 금액'
FROM buyTBL AS b
RIGHT JOIN userTBL AS u
ON b.userName = u.userName;

-- 3. userName을 기준으로 별칭을 사용하고 INNER JOIN 만들어보기
SELECT *
FROM userTBL AS u
INNER JOIN buyTBL AS b
ON u.userName = b.userName;

-- 1. 성이 이씨이면서 태어난 년도가 1999년인 구매한 아이템 정보를 표시해주세요!

SELECT u.userName, birthYear, prodName, 
(b.price * b.amount) AS '구입금액'
FROM userTBL AS u
INNER JOIN buyTBL AS b
ON u.userName = b.userName
WHERE u.userName LIKE '이%'
AND u.birthYear = 1999;

-- 2. 기준 테이블은 userTBL로 하고 LEFT JOIN을 사용하여 주문자 이름과, 
-- 주소, 전화번호, 상품 이름, 가격, 주문 수량 을 출력해보자 
-- (단, 주문 정보가 없는 경우 출력하지 않는다.)
SELECT u.addr, u.mobile, b.prodName, b.price, b.amount
FROM userTBL AS u
LEFT JOIN buyTBL AS b
ON u.userName = b.userName
WHERE b.userName IS NOT NULL;

-- 3. LEFT JOIN 을 사용하여 NULL 값도 확인할 수 있게 출력
SELECT *
FROM userTBL AS u
LEFT JOIN buyTBL AS b
ON u.userName = b.userName;

-- 4. userTBL 기준으로 INNER JOIN하고 buyTBL에서 수량이 
--    3개 이상인 데이터만 조회해라
SELECT *
FROM userTBL AS u
INNER JOIN buyTBL AS b
ON u.userName = b.userName
WHERE amount >= 3;

-- 5. buyTBL 기준으로 RIGHT JOIN하고 username이 
--    '이승기'이거나 '야스오'이면서 userTBL의 username이 
--    null이 아닌 데이터를 조회해라
SELECT *
FROM buyTBL AS b
RIGHT JOIN userTBL AS u
ON b.userName = u.userName
WHERE b.userName = '이승기' OR '야스오'
AND u.userName IS NOT NULL;

-- 6. 기준 테이블로 buyTBL을 사용해서 LEFT JOIN을 수행하고, 
--    1999년에 태어난 사람은 총 몇 개의 물품을 구매했는지 구하시오.
SELECT b.userName, u.birthYear, b.amount
FROM buyTBL AS b
LEFT JOIN userTBL AS u
ON b.userName = u.userName
WHERE u.birthYear = 1999;

-- 7. 기준 테이블로 userTBL을 사용해서 INNER JOIN을 수행하고, 
--    '책'을 구매한 사람들의 이름과 전화번호를 출력하시오.
SELECT u.userName, u.mobile, b.prodName
FROM userTBL AS u
INNER JOIN buyTBL AS b
ON u.userName = b.userName
WHERE b.prodName = '책';

-- 8. 기준 테이블로 buyTBL을 사용해서 RIGHT JOIN을 수행하고, 
--    '대구'에 사는 사람이 구매한 물품들을 출력하시오.
SELECT u.userName, u.addr, b.prodName
FROM buyTBL AS b
RIGHT JOIN userTBL AS u
ON b.userName = u.userName
WHERE u.addr = '대구';

SELECT * FROM userTBL;
SELECT * FROM buyTBL;






































