-- 第 8 关：持有两张信用卡的用户
SELECT
    c_name,
    c_id_card,
    c_phone
FROM
    client
WHERE
    c_id IN (
        SELECT
            b_c_id
        FROM
            bank_card
        WHERE
            b_type = '信用卡'
        GROUP BY
            b_c_id
        HAVING
            COUNT(*) >= 2
    )
ORDER BY
    c_id;