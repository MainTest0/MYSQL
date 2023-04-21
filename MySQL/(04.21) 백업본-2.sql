SELECT * FROM account_tb;
SELECT * FROM history_tb;
-- 1 -> 계좌번호 1111
-- 1번 계좌의 출금 내역
SELECT * FROM history_tb WHERE w_account_id = 1;

-- 1번 계좌의 입금 내역
SELECT * FROM history_tb WHERE d_account_id = 1;

-- 1번 계좌 입금 내역에 계좌번호 정보까지 결과 집합 만들기
SELECT h.id, h.amount, h.d_balance, a.number,
h.created_at
FROM history_tb AS h
INNER JOIN account_tb AS a
ON h.d_account_id = a.id
WHERE h.d_account_id = 1;

-- 1번 계좌에 출금 내역 뽑기
SELECT h.id, h.amount, h.w_balance, a.number,
h.created_at
FROM history_tb AS h
INNER JOIN account_tb AS a
ON h.w_account_id = a.id
WHERE w_account_id = 1;

-- 2단계
-- d_account_id 표시하기 -> 계좌번호로 표기
-- 1번 계좌 출금 내역
SELECT h.id, h.amount, h.w_balance,
	wa.number AS sender,
	IFNULL(h.d_account_id, 'ATM') AS receiver,
    da.number
FROM history_tb AS h
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
WHERE h.w_account_id = 1;

-- 1번 계좌에 입금 내역 +
-- 이체시 출금한 사람의 계좌번호 출력
SELECT h.id, h.amount, h.d_balance, 
	da.number AS receiver,
	IFNULL(h.w_account_id, 'ATM') AS sender,
    wa.number,
    h.created_at
FROM history_tb AS h
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
WHERE h.d_account_id = 1;

-- 출금내역 + 입금내역
SELECT * FROM history_tb 
WHERE w_account_id = 1
OR d_account_id = 2;

SELECT h.id, h.amount, h.d_balance, 
	da.number AS receiver,
	IFNULL(h.w_account_id, 'ATM') AS sender,
    wa.number,
    h.created_at
FROM history_tb AS h
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
WHERE h.d_account_id = 1
OR h.w_account_id = 1;

-- 입금 내역 : 쿼리 결정
SELECT h.id, h.amount, h.d_balance AS balance,
	h.created_at,
    IFNULL(wa.number, 'ATM') AS sender,
    da.number AS receiver
FROM history_tb AS h
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
WHERE h.d_account_id = 1;

-- 출금 내역
SELECT h.id, h.amount, h.w_balance AS balance,
	h.created_at,
    IFNULL(da.number, 'ATM') AS receiver,
    wa.number AS sender
FROM history_tb AS h
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
WHERE h.w_account_id = 1
OR h.d_account_id = 1;












