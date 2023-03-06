
-- 데이터 저장 (한줄 주석)
/*
	여러줄 주석
    주석
*/

/*
DROP이나 DELETE는 수행 후 주석처리하기

DROP TABLE student;
DROP TABLE subject;
DROP TABLE employee;
DROP TABLE customer;
DROP TABLE product;
*/

CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade INT NOT NULL,
    major VARCHAR(50)
);

-- 기본 문구 모양
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, ..) VALUES (값1, 값2)
INSERT INTO student(student_id, name, grade, major)
VALUES(1, '홍길동', 3, '컴퓨터공학과');

INSERT INTO student(student_id, name, grade, major)
VALUES(2, '김철수', 4, '전자공학과');

INSERT INTO student(student_id, name, grade, major)
VALUES(3, '이영희', 2, '경영학과');

INSERT INTO student(student_id, name, grade, major)
VALUES(4, '티모', 1, '롤학과');

-- 테이블의 데이터를 삭제하는 명령어 사용해보기
-- 테이블 안에 있는 데이터만 삭제하는 명령어이다.
-- DELETE FROM student;

-- 복수형으로 insert 쿼리문 작성하기 
INSERT INTO student(student_id, name, grade, major)
VALUES
	(1001, '김철수', 2, '컴퓨터공학과'), 
  (1002, '이영희', 3, '수학과'), 
  (1003, '박민수', 1, '전자공학과');

-- 복수형으로 데이터 3행을 넣어주세요 단 VALUE로 사용해보세요    
INSERT INTO student(student_id, name, grade, major)
VALUE
	(1004, '김철수2', 2, '컴퓨터공학과'), 
  (1005, '이영희2', 3, '수학과'), 
  (1006, '박민수2', 1, '전자공학과');  
    
-- insert 구문에서 복수행 쿼리를 실행할 때 하나라도 오류가 있으면
-- 데이터는 정상 저장되지 않는다.      
INSERT INTO student(student_id, name, grade, major)
VALUES
	(1007, '김철수3', 2, '컴퓨터공학과'), 
  (1008, '이영희3', 3, '수학과'), 
  (1008, '박민수3', 1, '전자공학과');

select * from student;

DESC customer;
DESC employee;

INSERT INTO customer(customer_id, name, email, address)
VALUES
	(1, '고객1', 'cus1@naver.com', '율하동 1-1'),
    (2, '고객2', 'cus2@naver.com', '율하동 2-2'),
	(3, '고객3', 'cus3@naver.com', '율하동 3-3'),
    (4, '고객4', 'cus4@naver.com', '율하동 4-4'),
    (5, '고객5', 'cus5@naver.com', '율하동 5-5');
    
INSERT INTO employee(employee_id, name, age, department)
VALUES
	(1, '직원1', 20, '생선판매부'),
    (2, '직원2', 24, '과일판매부'),
    (3, '직원3', 28, '마케팅부'),
    (4, '직원4', 32, '냉동판매부'),
    (5, '직원5', 36, '계산부서');
    
SELECT * FROM customer;
SELECT * FROM employee;

CREATE TABLE product(
	product_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    payment VARCHAR(20) NOT NULL
);

INSERT INTO product(product_id, name, payment)
VALUE(1, '족욕기', '신용카드');

INSERT INTO product(product_id, name, payment)
VALUE(2, '와인냉장고', '현금');

INSERT INTO product(product_id, name, payment)
VALUE(3, '몬스터RC카', '포인트결제');

SELECT * FROM product;

DESC student;

-- 테이블 제약사항에 NULL 허용 의미와 NOT NULL 허용 의미
-- student table안의 데이터를 변경하고 싶다.
-- 이미 생성된 테이블 제약 사항 변경하기
-- 스키마 구조 변경

ALTER TABLE student MODIFY grade INT NULL;

INSERT INTO student(student_id, name, major)
VALUES(1, '홍길동','검술학과');

SELECT * FROM student;
-- grade 제약을 NOT NULL로 변경 해보기
-- 테이블에 값이 들어가있는 상태
ALTER TABLE student MODIFY grade INT NOT NULL;
-- 이미 NULL이 들어가있는 데이터가 있기 때문에 1138에러
-- 하나의 행을 삭제하는 쿼리: WHERE절(조건절)
DELETE FROM student WHERE student_id = 1;

-- major 칼럼 제약을 NOT NULL로 변경해주세요
ALTER TABLE student MODIFY major VARCHAR(50) NOT NULL;

-- 칼럼 선언 부분을 생략도 가능하다. 단 전부 값을 넣으려고 하는 상황일 때

INSERT INTO student VALUES(5, '홍길동2',3, '검술학과');

-- INSERT 구문 컬럼명 선언 방식
--	1. 전부 작성하는 방법
--	2. 제약 사항이 null인 열이 있다면 넣고 싶은 열만 지정해서 작성할
--		수 있다.
--	3. 전부 데이터를 넣는 상황이라면 컬럼 선언 부분을 생략 가능하다.

-- NOT NULL과 DEFAULT 값 사용
-- DROP TABLE student;

CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name  VARCHAR(50) NOT NULL,
    grade INT NOT NULL,
    major VARCHAR(50) DEFAULT '미정' NOT NULL
);

DESC student;

-- 디폴트 제약을 사용했을 때 값을 넣는 방법 1.
INSERT INTO student(student_id, name, grade, major)
VALUES
	(1, 'John', 3, '경영학과'),
	(2, 'Jenny', 2, '경영학과'),
	(3, 'Mike', 1, DEFAULT),
	(4, 'David', 2, DEFAULT);

SELECT * FROM student;
-- 디폴트 제약을 사용했을 때 값을 넣는 방법 2.
-- 직접 값을 넣지않으면 스스로 defalut로 자동 저장된다.
INSERT INTO student(student_id, name, grade)
VALUES
	(5, '홍길동1', 3),
	(6, '홍길동2', 2),
	(7, '홍길동3', 3),
	(8, '홍길동4', 1);
    
CREATE TABLE subject (
  subject_id INT primary key,
  subject_name VARCHAR(50) NOT NULL,
  credit INT NOT NULL,
  department VARCHAR(50) NOT NULL,
  professor VARCHAR(50)  NOT NULL
);

DESC subject;
-- 테이블이 생성되어 있을 때 제약 변경 defalut 구문 추가
ALTER TABLE subject MODIFY professor VARCHAR(30) NOT NULL DEFAULT '';



CREATE TABLE `order` (
  id INT PRIMARY KEY,
  customer_order VARCHAR(50) NOT NULL,
  product_name VARCHAR(20) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL
);

-- DROP TABLE `order`;

-- 데이터를 입력하는 쿼리 구문을 작성해 주세요.

INSERT INTO `order` (id, customer_order, 
				product_name, quantity, order_date)
VALUES(1, '빠른배송바람', '냉장고', 5, '2023-03-06');

SELECT * FROM `order`;

INSERT INTO `order` (id, customer_order, 
				product_name, quantity, order_date)
VALUES(2, '빠른배송바람', '신라면', 2, 20230306);

-- DATE 타입에 값을 넣을 때 작은 따옴표나 큰 따옴표를 사용해도 되고
-- 정수값을 입력하여도 된다. 단! 날짜 형식에 맞는 값이어야 한다.
-- 1년은 12개월 인데 13이라는 값을 넣으면 알아서 오류를 일으켜 준다.
INSERT INTO `order` (id, customer_order, 
				product_name, quantity, order_date)
VALUES(3, '빠른배송바람', '오뚜기라면', 2, 20222206);

INSERT INTO `order` (id, customer_order, 
				product_name, quantity, order_date)
VALUES(3, '빠른배송바람', '오뚜기라면', 2, '20222206');

-- YYYY-MM-DD: MySQL 기본 DATE의 데이터 타입 기본 포멧
-- YYYY/MM/DD or YYYYMMDD: 명령어를 통해 이렇게 바꿀 수도 있음

-- AUTO_INCREMENT 사용해보기
-- 고객 테이블 생성

CREATE TABLE customer(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    address VARCHAR(100) NOT NULL
);

INSERT INTO customer(name, email, address)
VALUES
	('김철수', 'a@naver.com', '서울시 강남구 역삼동'),
    ('박영희', 'b@naver.com', '서울시 강동구 천호동'),
    ('김철수', 'c@naver.com', '서울시 강북구 역삼동');

SELECT * FROM customer;



















