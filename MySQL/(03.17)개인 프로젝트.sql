
-- 이 DB는 모든 유저의 접근 권한을 가진상태
USE myblog;

SHOW TABLES;

SELECT * FROM user;
SELECT * FROM customer;
DESC user;

INSERT INTO board(title, content, userId)
VALUES
	('테스트글1', '테스트 내용1', 1);

DELETE FROM user WHERE id = 1;

CREATE TABLE albums(
	userId INT NOT NULL,
	id INT PRIMARY KEY NOT NULL,
    title TEXT,
    FOREIGN KEY(userId) REFERENCES user(id)
);

CREATE TABLE user(
	id INT PRIMARY KEY
);

INSERT INTO user(id)
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

DROP TABLE albums;
DROP TABLE user;

select * from user;
desc albums;
desc user;

INSERT INTO albums(id, userId, title)
VALUES (113, "quidem molestiae enim");

INSERT INTO albums(userId, title)
VALUES (1, "sunt qui excepturi placeat culpa");

SELECT * FROM albums;

CREATE TABLE user(
	userId VARCHAR(50),
    id VARCHAR(50) UNIQUE KEY,
    title VARCHAR(500),
    body VARCHAR(1000)
);

SELECT * FROM user;
DESC user;
DROP TABLE user;

INSERT INTO user(userId, id, title, body)
VALUES('1', '1', '동물은', '사자');




















