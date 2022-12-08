-- 第 5 关：每份金额在 30000 ~ 50000 之间的理财产品
SELECT
    p_id,
    p_amount,
    p_year
FROM
    finances_product
WHERE
    p_amount BETWEEN 30000
    AND 50000
ORDER BY
    p_amount,
    p_year desc;