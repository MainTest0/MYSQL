/*
	서브 쿼리란 - 쿼리안에 쿼리가 있다.
    : 서브쿼리는 쿼리의 위치가 어디에 있느냐에 따라서 세 가지 종류로 나눌 수 있다.
    
    1. 중첩 서브쿼리(Nested Subquery) : WHERE 절에 사용하는 서브 쿼리
    2. 인라인 뷰(Inline View) : FROM 절에 사용하는 서브 쿼리
    3. 스칼라 서브쿼리(Scalaar Subquery) : SELECT 절에 사용하는 서브 쿼리	가능한 안쓰는 편
    
    : 내부쿼리는 괄호로 반드시 감싸져있어야 한다.
    
*/

-- db 생성 
create database reservationdb;
use reservationdb;

-- 예약 테이블 생성 
create table reservation(
	id int auto_increment, 
    name varchar(20) not null, 
    reserveDate date not null, 
    roomNum varchar(5) not null,
    primary key(id)
);

-- 고객 테이블 
create table customer(
	id int auto_increment, 
    name varchar(20) not null, 
    age int not null, 
    address varchar(10), 
    primary key(id)
);

-- 예약 테이블 데이터 생성 
insert into reservation values(1, '홍길동', '2020-04-01 00:00:00', 1);
insert into reservation values(2, '임꺽정', '2020-04-02 00:00:00', 2);
insert into reservation values(3, '장길산', '2020-04-03 00:00:00', 3);
insert into reservation values(4, '홍길동', '2020-04-04 00:00:00', 4);

-- 데이터 확인 
select * from reservation;

-- 데이터 수정 
update reservation set roomNum = '1001' where id = 1; 
update reservation set roomNum = '1002' where id = 2; 
update reservation set roomNum = '1003' where id = 3; 
update reservation set roomNum = '1004' where id = 4; 

-- 고객 테이블 데이터 생성 
select * from customer;

-- 고객 테이블 데이터 생성
insert into customer values(1, '홍길동', 20, '서울');
insert into customer values(2, '차무식', 30, '서울');
insert into customer values(3, '장길산', 24, '서울');
insert into customer values(4, '전우치', 33, '서울');

-- 고객 테이블 데이터 수정
update customer set address = '인천' where id = 2;
update customer set address = '서울' where id = 3;
update customer set address = '수원' where id = 4;

select * from customer;
select * from reservation;

-- 주소가 서울인 고객이 예약한 예약 정보만을 뽑아주세요
SELECT id, reserveDate, roomNum, name
FROM reservation
WHERE name in( SELECT name FROM customer WHERE address = '서울' );

SELECT id, reserveDate, roomNum, name
FROM reservation
WHERE name in( '홍길동', '장길산');

-- JOIN을 사용해서 주소가 서울인 고객이 예약한 예약정보만을 뽑아주세요
SELECT *
FROM reservation AS r
INNER JOIN customer AS c
ON r.name = c.name
WHERE address = '서울';

-- FROM 절 서브 쿼리
SELECT name, reservedRoom
FROM (
	SELECT name, reserveDate, (roomNum) AS reservedRoom
    FROM reservation
    WHERE roomNum > 1001
) AS reservationInfo;

/*
	서브쿼리의 특징
    서브쿼리를 사용하면 다음과같은 장점을 얻을 수 있다.
    1. 서브쿼리를 사용하면 쿼리를 구조화 시키므로, 
    쿼리의 각 부분을 명확히 구분할 수 있게 해준다.(쿼리의 가독성을 높여준다.)
    2. 서브쿼리는 복잡한 join 이나 UNION과 같은 동작을 수행할 수 있는 
    또 다른 방법을 제공합니다.
    3. 서브쿼리는 읽기 편하다.
    
    -- 스칼라 서브쿼리는 가능한 사용하지말자
*/

-- 서브쿼리를 이용하기
-- 2020-04-02 예약 정보 확인
-- 2020-04-02 일자로 예약한 고객의 id의 이름 조회
SELECT * FROM customer;
SELECT * FROM reservation;
DESC reservation;

SELECT *
FROM reservation 
WHERE name IN(
	SELECT name
	FROM customer
    WHERE reserveDate = 20200402
);



SELECT * FROM salaries;

-- 중첩 쿼리문을 사용하여 각 부서의 번호와 해당되는 부서의 현재 
-- 매니저의 사번, 성, 이름, 생일을 조회해보자
SELECT d.dept_no, d.emp_no, e.first_name, e.last_name, e.birth_date
FROM employees AS e
INNER JOIN dept_manager AS d
ON e.emp_no = d.emp_no
WHERE e.emp_no IN(
	SELECT emp_no
	FROM employees AS e	
    WHERE d.to_date = '9999-01-01'
);

SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT * FROM employees
WHERE first_name LIKE 'k%';

-- 인라인 뷰를 이용하여 성이 K로 시작하는 퇴사한 사람들의 가장 높은 연봉과
-- 퇴사일 출력
SELECT *
FROM (
SELECT e.first_name,d.to_date,max(s.salary)
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
WHERE d.to_date != '9999-01-01'
AND e.first_name LIKE 'K%'
GROUP BY first_name
) AS test2;

-- 인라인 뷰를 이용해서 생일이 1960년생 중 현재 일하고있는 
-- 사람들의 고용일과 부서이름을 출력하시오.
SELECT *
	FROM (
		SELECT e.birth_date, e.hire_date, 
		d.to_date, e.hire_date AS '고용일', de.dept_name AS '부서이름'
		FROM employees AS e
		INNER JOIN dept_emp AS d
		ON e.emp_no = d.emp_no
		INNER JOIN departments AS de
		ON d.dept_no = de.dept_no
		WHERE e.birth_date LIKE '1960%'
		AND d.to_date = '9999-01-01'
) AS test1;

SELECT e.birth_date, e.hire_date, d.to_date, e.hire_date AS '고용일', de.dept_name AS '부서이름'
    FROM employees AS e
    INNER JOIN dept_emp AS d
    ON e.emp_no = d.emp_no
    INNER JOIN departments AS de
    ON d.dept_no = de.dept_no
    WHERE e.birth_date LIKE '1960%'
    AND d.to_date = '9999-01-01';

    -- INNER JOIN departments AS de
    -- ON d.dept_no = de.dept_no

SELECT MONTH(birth_date) FROM employees;
SELECT DAY(birth_date) FROM employees;

SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM titles;

SELECT * FROM salaries
group by emp_no
ORDER BY 
emp_no DESC, 
salary DESC, 
from_date DESC;



SELECT e.first_name, MIN(s.salary), s.from_date, e.emp_no
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE INSTR(e.first_name, 'k') = 1
GROUP BY e.emp_no
ORDER BY s.from_date DESC;


-- 인라인 뷰를 이용하여LIKE를 쓰지않고(INSTR 함수 사용)
-- 성이 K로 시작하는 사람의
-- 연봉이 가장 작을 때의 from_date를 내림차순으로 출력
SELECT *
FROM(
	SELECT e.first_name, MIN(s.salary), s.from_date, e.emp_no
	FROM employees AS e
	INNER JOIN salaries AS s
	ON e.emp_no = s.emp_no
	WHERE INSTR(e.first_name, 'k') = 1
	GROUP BY e.emp_no
	ORDER BY s.from_date DESC
) AS 1query;

-- CREATE database bank;
-- USE bank;

-- 유저 테이블 설계해보기
CREATE TABLE user_tb(
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    fullname VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- 사용자의 계좌정보 테이블 설계
CREATE TABLE account_tb(
	id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    balance BIGINT NOT NULL COMMENT '계좌 잔액',
    user_id INT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- history에는 입 출금 내역 저장
-- 사용자 간 이체 내역 저장
-- BIGINT 8바이트 크기에 정수형
-- 조(10에 12) -- 경(10에 10승) -- 해(10에20승)
-- 자(10에 2) -- 양(10에 28)
-- 사용자들의 history 테이블 설계
CREATE TABLE history_tb(
	id INT AUTO_INCREMENT PRIMARY KEY COMMENT '거래 내역',
    amount BIGINT NOT NULL COMMENT '거래금액',
    w_account_id INT COMMENT '출금계좌 id',
    d_account_id INT COMMENT '입금계좌 id',
    w_balance BIGINT COMMENT '출금 요청된 계좌의 잔액',
    d_balance BIGINT COMMENT '입금 요청된 계좌의 잔액',
    created_at TIMESTAMP NOT NULL DEFAULT now()
);
SELECT * FROM user_tb;

-- 유저 샘플 데이터 
INSERT INTO user_tb(username, password, fullname, created_at) values('길동', '1234',
'고', now());
INSERT INTO user_tb(username, password, fullname, created_at) values('둘리', '1234',
'애기공룡', now());
INSERT INTO user_tb(username, password, fullname, created_at) values('콜', '1234',
'마이', now());

-- 계좌 테이블 샘플 데이터 
INSERT INTO account_tb(number, password, balance, user_id, created_at)
values('1111', '1234', 900, 1, now());
INSERT INTO account_tb(number, password, balance, user_id, created_at)
values('2222', '1234', 1100, 2, now());
INSERT INTO account_tb(number, password, balance, user_id, created_at)
values('333', '1234', 0, 3, now());


-- history 추적 내용(이체, 입금, 출금)
-- history 테이블에 insert 구문 작성
SELECT * FROM account_tb;
-- 이제 내역을 기록(1번 계좌에서 2번 계좌로 100원 이체)
-- amount:금액내역
-- w_balance:출금
-- d_balance:입금
INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id, created_at)
VALUES(100, 900, 1100, 1, 2, now());
SELECT * FROM history_tb;

-- 출금 내역(1번계좌에서 100원을 출금 처리)
INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id, created_at)
VALUES(100, 800, null, 1, null, now());
SELECT * FROM history_tb;

-- 입급 내역(1번 계좌에 500원 입금 처리)
INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id, created_at)
VALUES(500, null , 800 , null, 1, now());
SELECT * FROM history_tb;
SELECT * FROM account_tb;

ALTER TABLE history_tb AUTO_INCREMENT = 1;


-- 출금내역(3번이 1000원 출금, 잔액 0원인 상태를 거래 내역 기록)
INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id, created_at)
VALUES(1000, 1000 , null , 3, null, now());

SELECT * FROM history_tb;
SELECT * FROM user_tb;

-- 이체 연습
-- 입금 연습
-- 출금 연습

DESC history_tb;

-- 입금, 출금, 이체, 거래내역
-- 어떤 데이터를 뽑아낼 수 있는가?

-- 2번 계좌에서 300원 입금, 1번 계좌에서 2번 계좌로 200원 이체하기
INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id, created_at)
	VALUES(300, null, 1200, null, 2, now()),
    (200, 1300, 1500, 1, 2, now());
    
SELECT * FROM history_tb;

SELECT amount, d_account_id, d_balance, now() 
FROM history_tb 
WHERE d_account_id = 2;

SELECT amount, w_account_id, w_balance, now() 
FROM history_tb 
WHERE w_account_id = 2;

SELECT amount, d_account_id, d_balance, 
w_account_id, w_balance, now()
FROM history_tb
WHERE d_account_id = 2 OR w_account_id = 2;

-- 트랜잭션 처리해보기
-- 1단계
START TRANSACTION;

INSERT INTO user_tb(username, password, fullname)
VALUES ('John', '1234', 'kim');

INSERT INTO user_tb(username, password, fullname)
VALUES ('Mike', '222', 'Lee');

ROLLBACK;

COMMIT;
SELECT * FROM user_tb;
/*
	계좌 간 이체
    계좌 A의 잔액은 3000원이다.
    계좌 B의 잔액은 0원이다.
    계좌 A에서 B로 3000원을 이체하는게 목적
*/
-- 테스트를 위한 설정
UPDATE account_tb SET balance = 3000 WHERE id = 1;
UPDATE account_tb SET balance = 0 WHERE id = 2;

SELECT * FROM account_tb;
SELECT * FROM history_tb;

START TRANSACTION;

UPDATE account_tb SET balance = balance - 3000
WHERE id = 1;
UPDATE account_tb SET balance = balance + 3000
WHERE id = 2;

INSERT INTO history_tb(amount, w_balance, d_balance,
					w_account_id, d_account_id)
VALUES (3000, (SELECT balance FROM  account_tb WHERE id = 1),
			(SELECT balance FROM account_tb WHERE id = 2),
            1, 2);

COMMIT;

SELECT * FROM account_tb;
SELECT * FROM history_tb;

-- history_tb 에서 입금 내역과 입금 계좌 번호를 
-- join 을 사용해서 출력 하시오
SELECT h.d_account_id, h.d_balance, a.number
FROM history_tb AS h
JOIN account_tb AS a
ON h.d_account_id = a.user_id;

-- history_tb 에서 출금 내역과 출금 계좌 번호를 
-- join 을 사용해서 출력 하시오 
SELECT h.w_account_id, h.w_balance, a.number
FROM history_tb AS h
JOIN account_tb AS a
ON h.w_account_id = a.user_id;
























