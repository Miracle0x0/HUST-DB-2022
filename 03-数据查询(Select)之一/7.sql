-- 第 7 关：未购买任何理财产品的武汉居民
SELECT
    c_name,
    c_phone,
    c_mail
FROM
    client
WHERE
    c_id_card LIKE '4201%'
    AND NOT EXISTS (
        SELECT
            *
        FROM
            property
        WHERE
            c_id = pro_c_id
            AND pro_type = 1
    )
ORDER BY
    c_id;