
USE mydb;

SELECT * FROM customer;

USE myblog;

-- user 테이블 생성
-- 제약
-- 1. id 컬럼에 pk 부여
-- 2. username : 사용자 이름 100자 NOT NULL, 중복 허용 불가(UNIQUE)
-- password : 100자 NOT NULL처리, 중복 허용
-- email : 100자 NOT NULL
-- address : 100자 NULL 허용
-- userRole : ADMIN, MANAGER, USER
-- 언제 회원가입했는지
-- CREATE DATE 
CREATE TABLE user(
	id int PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(100),
    userRole VARCHAR(20),
    createDate TIMESTAMP
);

SELECT * FROM user;

-- 블로그에 대한 정보를 저장하는 테이블 필요함
CREATE TABLE board(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content BLOB,
	readCount INT DEFAULT 0,
    userId INT,
    FOREIGN KEY(userId) REFERENCES user(id)
);

-- user 와 boader테이블의 연관 차수 1 : N

-- 댓글 테이블 만들기
CREATE TABLE reply(
	id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(300) NOT NULL,
    createDate TIMESTAMP,
    boardId INT,
    userId INT,
    FOREIGN KEY(boardId) REFERENCES board(id),
    FOREIGN KEY(userId) REFERENCES user(id)
); 

SELECT * FROM reply;


-- user : reply - > 1 : N
-- board : reply -> 1 : N

-- 현재 날짜,시간
SELECT NOW();

INSERT INTO user
(username, password, email, address, 
	userRole, createDate)
VALUES('홍길동', '1234', 'a@naver.com', '부산시 중구',
'USER', now());

SELECT * FROM user;

-- username과 password가 일치하는 사용자 찾아보기
SELECT * 
FROM user
WHERE username = '홍길동'
	AND password = '1234';

SELECT * FROM board;
DESC board;

INSERT INTO board(title, content, userId)
VALUES
	('첫번째 게시글', '자바는 쉬운거에요', 3);

ALTER TABLE board MODIFY content text;

DELETE FROM board WHERE id = 2;



































