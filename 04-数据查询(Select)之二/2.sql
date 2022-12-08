SELECT t1.pro_c_id
FROM (
        SELECT pro_c_id,
            COUNT(pro_pif_id) AS p_cnt
        FROM property
        WHERE pro_type = 1
        GROUP BY pro_c_id
        HAVING COUNT(pro_pif_id) >= 3
    ) t1
    JOIN (
        SELECT pro_c_id,
            COUNT(pro_pif_id) AS f_cnt
        FROM property
        WHERE pro_type = 3
        GROUP BY pro_c_id
        HAVING COUNT(pro_pif_id) >= 3
    ) t2 ON t1.pro_c_id = t2.pro_c_id
WHERE f_cnt < p_cnt;