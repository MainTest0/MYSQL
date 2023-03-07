
-- 학교와 학생의 관계를 지어서 만들기
CREATE TABLE school(
	school_id INT PRIMARY KEY,
    school_name VARCHAR(20) NOT NULL,
    city VARCHAR(20)
);
-- school은 부모 테이블, student는 자식 테이블로 볼 수 있다.
CREATE TABLE student(
	student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    grade VARCHAR(3) NOT NULL,
    school_id INT,
    -- 외래키라고 지정하기 참조한다 school안의 컬럼명
    FOREIGN KEY(school_id) REFERENCES school(school_id)
);

-- 데이터 들어가는 모습 살펴보기
INSERT INTO school(school_id, school_name, city)
VALUES
	(1, '서울대학교', '서울'),
	(2, '고려대학교', '서울'),
	(3, '연세대학교', '서울'),
	(4, '한양대학교', '서울');
    
SELECT * FROM school;

INSERT INTO student(student_id, student_name, grade, school_id)
VALUES
	(1, '홍길동', '1학년', 1),
	(2, '김유신', '2학년', 2),
	(3, '이순신', '1학년', 3),
	(4, '유관순', '3학년', 1),
	(5, '안중근', '2학년', 4);
    
-- 제약 키 FK 사용하게 된다면 여러가지 제약 사항이 생기게 된다.
SELECT * FROM student;
DESC student;

INSERT INTO student(student_id, student_name, grade,school_id)
VALUES
	(6, '야스오', '1학년', 10);
/*
Error Code: 1452.
Cannot add or update a child row:
a foreign key constraint fails
--foreign key 제약이 실패했다.--
(`mydb`.`student`, CONSTRAINT `student_ibfk_1`
FOREIGN KEY (`school_id`) REFERENCES `school`
(`school_id`))
*/

-- 야구 팀과 야구 선수 관계 1 : N
CREATE TABLE team(
	id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL
);

CREATE TABLE player(
	player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    FOREIGN KEY(team_id) REFERENCES team(id)
);

INSERT INTO team(team_name)
VALUES
	('LG트윈스'),
	('NC다이노스'),
	('두산베어스');
    
INSERT INTO player(player_name, team_id)
VALUES
	('허경민', 1),
	('김하성', 2),
	('최원준', 3);
    
SELECT * FROM team;
SELECT * FROM player;

-- 1 : N 관계
-- 학원과 수강생
-- 회사와 직원과 부서

CREATE TABLE department(
	id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(20) NOT NULL
);

CREATE TABLE employee(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(20) NOT NULL,
    department_id INT,
    FOREIGN KEY(department_id) REFERENCES department(id)
);

INSERT INTO department(department_name)
VALUES
	('개발부'),
	('인사부'),
	('마케팅부'),
	('기획부');
SELECT * FROM department;
SELECT * FROM employee;
INSERT INTO employee(employee_name, department_id)
VALUES
	('홍길동', 1),
	('유관순', 2),
	('이순신', 3),
	('김유신', 4);

-- DROP TABLE product;
CREATE TABLE product(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    price INT NOT NULL
);
-- DROP TABLE `order`;
CREATE TABLE `order`(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    product_id INT,
    FOREIGN KEY(product_id) REFERENCES product(id)
);

INSERT INTO product(name, price)
VALUES
	('노트북', 1000000),
	('스마트폰', 700000),
	('키보드', 50000);
    
INSERT INTO `order`(order_date, product_id)
VALUES
	(20220215, 2),
	(20220216, 1),
	(20220217, 3);
    
SELECT * FROM product;
SELECT * FROM `order`;


















