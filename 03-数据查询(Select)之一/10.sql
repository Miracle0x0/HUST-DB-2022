-- 第 10 关：投资总收益前三名的客户
SELECT
    c_name,
    c_id_card,
    SUM(pro_income) AS total_income
FROM
    client
    INNER JOIN property ON pro_c_id = c_id
    AND pro_status = '可用'
GROUP BY
    c_id
ORDER BY
    SUM(pro_income) desc
LIMIT
    3;