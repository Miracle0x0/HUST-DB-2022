-- 第 16 关：持有完全相同基金组合的客户
SELECT
    t1.c_id c_id1,
    t2.c_id c_id2
FROM
    (
        SELECT
            pro_c_id c_id,
            GROUP_CONCAT(
                DISTINCT pro_pif_id
                ORDER BY
                    pro_pif_id
            ) f_id
        FROM
            property
        WHERE
            pro_type = 3
        GROUP BY
            pro_c_id
    ) t1,
    (
        SELECT
            pro_c_id c_id,
            GROUP_CONCAT(
                DISTINCT pro_pif_id
                ORDER BY
                    pro_pif_id
            ) f_id
        FROM
            property
        WHERE
            pro_type = 3
        GROUP BY
            pro_c_id
    ) t2
WHERE
    t1.c_id < t2.c_id
    AND t1.f_id = t2.f_id;