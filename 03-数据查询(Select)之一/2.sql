-- 第 2 关：邮箱为 null 的客户
SELECT
    c_id,
    c_name,
    c_id_card,
    c_phone
FROM
    client
WHERE
    c_mail is NULL;