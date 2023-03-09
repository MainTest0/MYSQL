
CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    major VARCHAR(50) NOT NULL
);

CREATE TABLE subject(
	subject_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    professor VARCHAR(50) NOT NULL
);
-- 학생과 수강 테이블의 관계?	1:N 관계
-- 학생에서는 한명의 레코드 존재, 
-- 수강 테이블에는 한 학생이 여러과목을 들음
-- 과목과 수강 테이블의 관계?	1:1 관계
CREATE TABLE enrollment(
	enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY(student_id) REFERENCES student(student_id),
    FOREIGN KEY(subject_id) REFERENCES subject(subject_id)
);

-- 한 사람이 여러 개의 도시에서 여러번 여행을 다녀온 경우를 테이블로 구축해보세요.
-- 사람과 도시의 관계를 관계 차수로 표현해보세요 1:N
-- 한 사람이 여러 도시를 방문할 수 있고, 한 도시에는 여러 사람이 방문한다.(중간테이블 필요)
-- 테이블 이름 : person, city, travel
CREATE TABLE person(
	person_id INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE city(
	city_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
-- 중간 테이블 만들기 N:N관계
CREATE TABLE travel(
    person_id INT NOT NULL,
    city_id INT NOT NULL,
    trip_date DATE,
    -- 3개를 하나의 pk로 만듬
    PRIMARY KEY(person_id, city_id, trip_date),
    FOREIGN KEY(city_id) REFERENCES city(city_id),
    FOREIGN KEY(person_id) REFERENCES person(person_id)
);

-- 데이터 들어가는 모습 살펴보기
INSERT INTO person VALUES
	(1, '김영희'),
	(2, '박철수'),
	(3, '이민호'),
	(4, '한지민'),
	(5, '송혜교');
    
INSERT INTO city VALUES
	(1, '서울'),
	(2, '부산'),
	(3, '제주'),
	(4, '홍콩'),
	(5, '도쿄');

INSERT INTO travel VALUES
	(1, 1, 20220710),
	(1, 2, 20220710),
	(2, 5, 20220710),
	(2, 4, 20220710),
	(3, 3, 20220710),
	(4, 5, 20220710),
	(1, 4, 20220710);

-- 문제 JOIN 구문 활용해서 어떤 사람이 어떤 도시에
-- 방문했다는 것까지 2문제씩만 만들기
-- 1. INNER JOIN으로 성이 김인 사람이 방문한 도시 출력
SELECT *
FROM person AS p
INNER JOIN travel AS t
ON p.person_id = t.person_id
WHERE p.name LIKE '김%';

-- 고객, 주문목록 --> 1 : N
-- 홍길동 --> 신발, 홍길동
-- 		--> 컴퓨터, 홍길동
-- 고객, 상품정보, 주문목록 -->  N : M --> 중간 테이블 주문 목록
-- 주문 --	1(홍길동), 1(신발), "일자"

-- 테이블 설계
-- 고객, 상품, 주문 목록
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
CREATE TABLE product(
	product_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
CREATE TABLE product_list(
	id INT PRIMARY KEY,
	customer_id INT NOT NULL,
    product_id INT NOT NULL,
    amound INT NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id)
);










