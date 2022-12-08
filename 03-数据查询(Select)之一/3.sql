-- 第 3 关：既买了保险又买了基金的用户
SELECT
    c_name,
    c_mail,
    c_phone
FROM
    client
WHERE
    c_id IN (
        SELECT
            pro_c_id
        FROM
            property
        WHERE
            pro_type = 2
    )
    AND c_id IN (
        SELECT
            pro_c_id
        FROM
            property
        WHERE
            pro_type = 3
    )
ORDER BY
    c_id;