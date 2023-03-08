
CREATE TABLE student(
	id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade VARCHAR(3) NOT NULL
);

CREATE TABLE product(
	product_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price INT NOT NULL
);

INSERT INTO product(product_id, name, price)
VALUES
	(1, '족욕기', 50000),
	(2, '삼다수', 1300),
	(3, '담요', 20000),
    (4, '버즈', 200000);
    
SELECT * FROM product;
DROP TABLE buyTBL;

CREATE TABLE buyTBL(
	id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    product_name VARCHAR(50) NOT NULL
);

INSERT INTO buyTBL(id, name, product_name)
VALUES
	(1, '홍길동', '족욕기'),
    (2, '김상배', '담요'),
    (3, '김두한', '삼다수'),
    (4, '최요한', '버즈');
    
SELECT b.name, b.product_name
FROM product AS p
INNER JOIN buyTBL AS b
ON p.product_id = b.id;















