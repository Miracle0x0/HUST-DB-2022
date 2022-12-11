-- 第 14 关：第 N 高问题

-- 1. 方案一

SELECT i_id, i_amount
FROM (
        SELECT
            i_id,
            i_amount,
            dense_rank() OVER (
                ORDER BY
                    i_amount DESC
            ) AS rk
        FROM insurance
    ) t
WHERE rk = 4
ORDER BY i_id;

-- 2. 方案二

SELECT i_id, i_amount
FROM insurance
WHERE i_amount = (
        SELECT
            DISTINCT i_amount
        FROM insurance
        ORDER BY i_amount DESC
        limit 3, 1
    );