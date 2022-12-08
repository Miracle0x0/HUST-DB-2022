-- 第 14 关：第 N 高问题
SELECT
    i_id,
    i_amount
FROM
    (
        SELECT
            i_id,
            i_amount,
            dense_rank() OVER (
                ORDER BY
                    i_amount DESC
            ) AS rk
        FROM
            insurance
    ) t
WHERE
    rk = 4
ORDER BY
    i_id;