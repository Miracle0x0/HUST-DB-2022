-- 第 4 关：办理了储蓄卡的客户信息
SELECT
    client.c_name,
    client.c_phone,
    bank_card.b_number
FROM
    client
    JOIN bank_card ON client.c_id = bank_card.b_c_id
WHERE
    bank_card.b_type = '储蓄卡'
ORDER BY
    c_id;