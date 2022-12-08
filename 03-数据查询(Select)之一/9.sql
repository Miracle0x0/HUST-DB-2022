-- 第 9 关：购买了货币型基金的用户信息
SELECT
    c_name,
    c_phone,
    c_mail
FROM
    client
WHERE
    c_id IN (
        SELECT
            pro_c_id
        FROM
            property
        WHERE
            pro_type = 3
            AND pro_pif_id IN (
                SELECT
                    f_id
                FROM
                    fund
                WHERE
                    f_type = '货币型'
            )
    )
ORDER BY
    c_id;