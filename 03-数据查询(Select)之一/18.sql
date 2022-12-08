-- 第 18 关：至少有一张信用卡余额超过 5000 元的客户信用卡总余额
SELECT
    b_c_id,
    SUM(b_balance) AS credit_card_amount
FROM
    bank_card
WHERE
    b_type = '信用卡'
GROUP BY
    b_c_id
HAVING
    MAX(b_balance) >= 5000
ORDER BY
    b_c_id;