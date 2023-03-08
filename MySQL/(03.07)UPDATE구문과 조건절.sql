CREATE TABLE `order` (
  id INT PRIMARY KEY,
  order_name VARCHAR(20) NOT NULL,
  product_name VARCHAR(20) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL
);


INSERT INTO `order` (id, order_name, product_name, quantity, order_date) 
VALUES
(1, '홍길동', '피자', 2, '2022-02-26'),
(2, '김영희', '치킨', 3, '2022-02-26'),
(3, '이철수', '햄버거', 1, '2022-02-27'),
(4, '박지민', '스테이크', 2, '2022-02-27'),
(5, '최영희', '짬뽕', 1, '2022-02-27'),
(6, '박서준', '초밥', 3, '2022-02-28'),
(7, '김민지', '파스타', 2, '2022-02-28'),
(8, '정재은', '토스트', 1, '2022-02-28'),
(9, '신은주', '감바스', 2, '2022-03-01'),
(10, '유지훈', '돈까스', 1, '2022-03-01');

DESC `order`;
-- DROP TABLE `order`;

-- UPDATE 구문 쓸 때는 천천히 WHERE절 확인하기
-- 1.아이디가 1인 주문의 상품 수량을 5개로 수정
UPDATE `order`
SET quantity = 5
WHERE id = 1;

-- 2. 아이디가 3인 주문의 수령인 메뉴를 '감바스'로 수정
UPDATE `order`
SET product_name = '감바스'
WHERE id = 3;

-- 3. id가 5인 주문의 주문 일자를 '2022-01-05'로 수정
-- UPDATE 구문에 DATE 타입 값 입력시에는 작은따옴표로 감싸주기
-- SET order_date = '2022-01-05'
UPDATE `order`
SET order_date = 20220105
WHERE id = 5;

-- 테이블 구조 변경 해보기 : 컬럼 추가하는 방법
-- ALTER TABLE `order` ADD COLUMN address VARCHAR(100);
ALTER TABLE `order` ADD address VARCHAR(100);

-- 주문 수량이 2개 이상이고, 상품명이 '피자'인 주문의 수령인 이름을
-- '김철수'로 수정
UPDATE `order`
SET order_name = '김철수'
WHERE quantity >= 2
	AND product_name = '피자';

SELECT * FROM `order`;

-- 주문 날짜가 '2022-02-28'이고, 상품명이 '초밥'인 주문의 
-- 주문 수량을 5개로 수정
UPDATE `order`
SET quantity = 5
WHERE order_date = 20220228
	AND product_name = '초밥';
-- 주문 수량이 1개 이하이고, 상품명이 '감바스' 인 주문의 수령인
-- 주소를 '경기도 성남시'로 수정
UPDATE `order`
SET address = '경기도 성남시'
WHERE quantity <= 1
	AND product_name = '감바스';

-- DROP TABLE member;

CREATE TABLE member(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(100) NOT NULL
);

INSERT INTO member (name, email, phone, address)
VALUES 
('홍길동', 'hong@test.com', '010-1234-5678', '서울시 강남구'),
('김영희', 'kim@test.com', '010-2345-6789', '서울시 서초구'),
('이철수', 'lee@test.com', '010-3456-7890', '서울시 종로구'),
('박민지', 'park@test.com', '010-4567-8901', '서울시 마포구'),
('최재영', 'choi@test.com', '010-5678-9012', '서울시 강서구'),
('강영식', 'kang@test.com', '010-6789-0123', '서울시 송파구');

UPDATE member
SET address = '서울시 중구'
WHERE name = '이철수';

SELECT * FROM member;
INSERT INTO member (name, email, phone, address)
VALUES 
('홍길동2', 'hong@test.com', '010-1234-5678', '서울시 강남구');

-- id가 2인 회원의 이름과 전화번호를 각각 '임성준', '010-9876-5432'로 수정
UPDATE member
SET name = '임성준', phone = '010-9876-5432'
WHERE id = 2;
-- id가 5인 회원의 이메일과 주소를 각각 'leejaehyun@test.com
-- , '서울시 강서구'로 수정
UPDATE member
SET email = 'leejaehyun@test.com', address = '서울시 강서구'
WHERE id = 5;

CREATE TABLE movie(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director VARCHAR(20) NOT NULL,
    release_date DATE NOT NULL,
    genre VARCHAR(30) NOT NULL,
    rating DECIMAL(3, 2)
);
DROP TABLE movie;
DESC movie;

INSERT INTO movie(title, director, release_date, genre,rating)
VALUES
	('괴물','봉준호',20060727, '드라마',8.28),
	('극한직업','이병헌',20190123, '코미디',9.20),
	('명량','김한민',20140730, '사극',9.17),
	('신과함께-죄와 벌','김용화',20171220, '판타지',7.56),
	('밀양','임권택',20160907, '드라마',7.76),
	('반도','연상호',20200715, '액션',6.71),
	('베테랑','류승완',20150805, '액션',8.49),
	('변호인','양우성',20131218, '드라마',8.41),
	('군함도','류승완',20170726, '사극',8.01),
	('암살','최동훈',20150722, '액션',8.37);

SELECT * FROM movie; 

UPDATE movie
SET title = '아바타2',
	director = '봉준호',
    release_date = 20230308,
    genre = '판타지',
    rating = 9.38
WHERE id = 1;

















