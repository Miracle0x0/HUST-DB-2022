SELECT *
FROM (
        SELECT *,
            DENSE_RANK() OVER (
                ORDER BY cc DESC
            ) AS prank
        FROM (
                SELECT pro_pif_id,
                    COUNT(pro_c_id) AS cc
                FROM property
                WHERE pro_type = 1
                    AND pro_pif_id IN (
                        SELECT pro_pif_id
                        FROM property
                        WHERE pro_type = 1
                            AND pro_pif_id != 14
                            AND pro_c_id IN (
                                SELECT pro_c_id
                                FROM (
                                        -- * 产品 14 的相似理财产品编号
                                        SELECT *
                                        FROM (
                                                SELECT pro_c_id,
                                                    DENSE_RANK() OVER(
                                                        ORDER BY total_quantity DESC
                                                    ) rk
                                                FROM (
                                                        SELECT pro_c_id,
                                                            SUM(pro_quantity) AS total_quantity
                                                        FROM property
                                                        WHERE pro_pif_id = 14
                                                            AND pro_type = 1
                                                        GROUP BY pro_c_id
                                                    ) t1
                                            ) t2
                                        WHERE rk <= 3
                                    ) t3
                            )
                    )
                GROUP BY pro_pif_id
            ) t4
    ) t5
WHERE prank <= 3
ORDER BY prank,
    pro_pif_id;