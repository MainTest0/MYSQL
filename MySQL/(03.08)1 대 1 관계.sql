
-- 만약 member 테이블이 존재한다면 삭제하고 다시만들어
DROP TABLE IF EXISTS member;

-- 회원 정보와 회원 등급 정보 1:1 관계로 설계
CREATE TABLE member(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(100)
);

CREATE TABLE member_grade(
	member_id INT PRIMARY KEY,
    grade VARCHAR(10),
    point INT,
    FOREIGN KEY(member_id) REFERENCES member(id)
);

DESC member_grade;

-- 직원 정보와 직위 정보를 저장하는 테이블 설계 1 : 1 관계
-- id, name, hire_date(고용일)

DROP TABLE IF EXISTS employee;

CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL
);

-- employee_position 직원의 지위 정보 (대리, 신입사원)
-- position VARCHAR, 해고일자(null 값 가지게끔)

CREATE TABLE employee_position(
	employee_id INT PRIMARY KEY,
	position VARCHAR(10) NOT NULL,
    dismissal DATE,
    FOREIGN KEY(employee_id) REFERENCES employee(id)
);

DESC employee_position;
DESC employee;

DROP TABLE product_detail;

CREATE TABLE product(
		id INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        price INT
);

CREATE TABLE product_detail(
	product_id INT PRIMARY KEY,
    description TEXT,
    FOREIGN KEY(product_id) REFERENCES product(id)
);





























