
-- 데이터 베이스 생성
-- CREATE DATABASE <데이터 베이스 이름>
CREATE DATABASE mydb;

-- DB를 사용하려면 사용한다고 명령어를 실행해야한다.
use mydb;
-- 테이블 생성, SQL 작성시 어떤 DB를 사용해야하는지 먼저 선택 되어야 한다.

-- 굵은 글씨는 MySQL에서 쓰는 예약어
-- 예약어는 대문자로 사용하고 우리가 직접 정의하는 단어는 소문자
-- 테이블 생성
-- VARCHAR의 의미 : 문자 값을 넣을 데이터타입 최대 50자까지
-- VAR: 가변 0~50자까지 늘려지고 줄어짐
-- 테이블 생성시 제약사항 정해주는 중
-- 데이터를 밀어넣을 때 빈 값을 넣으면 오류 생김
-- 마지막은 쉼표 안씀
CREATE TABLE student(
	student_id INT,
    name VARCHAR(50) NOT NULL,
    grade INT NOT NULL,
    major VARCHAR(50) NOT NULL
);

SELECT * FROM student;
-- 이 테이블을 설명해줘
DESC student;

-- 과목 테이블 생성하기
-- VARCHAR와 CHAR의 차이점
-- VARCHAR는 3글자를 쓰면 메모리공간을 3만큼만 차지함(가변)
-- CHAR는 3글자써도 메모리공간 50 차지함(고정)
CREATE TABLE subject (
	subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credit INT NOT NULL,
    department VARCHAR(50) NOT NULL,
    professor CHAR(50) NOT NULL
);

SELECT * FROM subject;
DESC subject;

-- 고유키 선언
DESC student;
-- 이미 생성된 테이블에 기본키 추가하는 쿼리 사용 방법
-- 변경하기 (ALTER)
ALTER TABLE student ADD PRIMARY KEY(student_id);
-- 사전 기반 지식: 특정 칼럼을 기본키로 만들게 되면 중복된 데이터를
-- 허용 못하고 NULL 값이 있어서는 안된다.

-- subject 테이블에 PK 추가 대상 - subject_id
-- 제약 확인하기
ALTER TABLE subject ADD PRIMARY KEY(subject_id);
DESC subject;

-- 생성될 시점의 테이블 생성 명령어를 보여줘
SHOW CREATE TABLE student;

-- 테이블을 삭제하는 명령어 확인
-- DROP TABLE student;
-- DROP TABLE subject;

-- 학생테이블 생성 pk 추가
CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade INT NOT NULL,
    major VARCHAR(50) NOT NULL
);

desc student;

CREATE TABLE subject(
	subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    CREDIT INT NOT NULL,
    DEPARTMENT VARCHAR(10) NOT NULL,
    professor VARCHAR(20) NOT NULL
);

desc subject;

CREATE TABLE employee(
	employee_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    department VARCHAR(50) NOT NULL
);

SELECT * FROM employee;
desc employee;

CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL
);

SELECT * FROM customer;
desc customer;

-- 이런 설계를 테이블 모델링이라고 한다.
CREATE TABLE product(
	id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    dscription TEXT
);
DESC product;

-- 쿠팡같은 주문 DB 모델링
-- order 예약어 테이블 이름을 선정할 수 없다.
-- 하지만 강제적으로 작은 따옴표를 사용해서 테이블 이름이라고 명시할
-- 수 있다.(`1옆에)
CREATE TABLE `order`(
	id INT PRIMARY KEY,
    customer_order VARCHAR(50),
    product_name VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL
);
desc `order`;

CREATE TABLE bus_table(
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(20) NOT NULL,
    bus_id INT NOT NULL,
    bus_point VARCHAR(30) NOT NULL,
    route VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL
);

desc bus_table;



