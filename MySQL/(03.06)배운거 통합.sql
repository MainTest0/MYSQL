
CREATE TABLE department(
	code INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    boss VARCHAR(50) NOT NULL
);

ALTER TABLE department MODIFY boss VARCHAR(50) NULL;

INSERT INTO department(name, role, location, boss)
VALUES
	('마케팅부', '홍보담당', '서울시 강남구 역삼동', '김철수'),
	('개발부', '개발담당', '서울시 강남구 역삼동', '박영희'),
	('전략기획부', '분석,정리담당', '서울시 강남구 역삼동', DEFAULT);
    
-- DROP TABLE department;
    
-- 전략기획부 폐지
DELETE FROM department WHERE code = 3;
    
DESC department;
SELECT * FROM department;

CREATE TABLE receipt(
	division_code INT AUTO_INCREMENT PRIMARY KEY,
    receipt_name VARCHAR(50) NOT NULL,
    method_code INT NOT NULL,
    receipt_date DATE NOT NULL,
    applicant_name VARCHAR(50) NOT NULL,
    applicant_code INT NOT NULL,
    department_code INT NOT NULL
);

INSERT INTO receipt(receipt_name, method_code,receipt_date,
				applicant_name, applicant_code, department_code)
VALUES
	('최성훈', 103, 20230306, '최성훈', 2, 1),
	('이문세', 531, 20230207, '이문세', 8, 3),
	('최경호', 938, 20230903, '최경호', 11, 2);
    
SELECT * FROM receipt;
DESC receipt;

CREATE TABLE test(code_A INT);

-- NULL값 바꾸기
ALTER TABLE test MODIFY code_A INT NOT NULL;

-- 기본키 추가하기
ALTER TABLE test ADD PRIMARY KEY (code_A);

DESC test;






