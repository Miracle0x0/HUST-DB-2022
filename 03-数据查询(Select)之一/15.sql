-- 第 15 关：基金收益两种方式排名
-- (1) 基金总收益排名(名次不连续)
SELECT
    pro_c_id,
    SUM(pro_income) as total_revenue,
    RANK() OVER(
        ORDER BY
(SUM(pro_income)) desc
    ) 'rank'
FROM
    property
WHERE
    pro_type = 3
GROUP BY
    pro_c_id
ORDER BY
    total_revenue desc,
    pro_c_id;

-- (2) 基金总收益排名(名次连续)
SELECT
    pro_c_id,
    SUM(pro_income) as total_revenue,
    DENSE_RANK() OVER(
        ORDER BY
(SUM(pro_income)) desc
    ) 'rank'
FROM
    property
WHERE
    pro_type = 3
GROUP BY
    pro_c_id
ORDER BY
    total_revenue desc,
    pro_c_id;