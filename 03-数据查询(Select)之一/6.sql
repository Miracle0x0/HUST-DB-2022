-- 第 6 关：商品收益的众数
SELECT
    b.pro_income,
    b.cnt AS presence
FROM
    (
        SELECT
            a.pro_income,
            a.cnt,
            MAX(a.cnt) over() AS max_cnt
        FROM
            (
                SELECT
                    pro_income,
                    COUNT(*) AS cnt
                FROM
                    property
                GROUP BY
                    pro_income
            ) AS a
    ) AS b
where
    b.cnt = b.max_cnt;