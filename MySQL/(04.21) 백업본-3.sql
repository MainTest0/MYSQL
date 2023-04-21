
-- CASE WHEN THEN END 문법 배우기
SELECT h.id, h.amount, h.w_balance AS balance,
    IFNULL(da.number, 'ATM') AS receiver,
    wa.number AS sender,
    h.created_at
FROM history_tb AS h
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
WHERE h.w_account_id = 1
OR h.d_account_id = 1;

-- --------------------------------
SELECT h.id, h.amount,
CASE 
	WHEN h.w_account_id = 1 THEN (h.w_balance)
	WHEN h.d_account_id = 1 THEN (h.d_balance)
    END AS balance,
IFNULL(da.number, 'ATM') AS receiver,
IFNULL(wa.number, 'ATM') AS sender,
h.created_at
FROM history_tb AS h
LEFT JOIN account_tb AS da
ON h.d_account_id = da.id
LEFT JOIN account_tb AS wa
ON h.w_account_id = wa.id
WHERE h.d_account_id = 1
OR h.w_account_id = 1;






















