-- 第 17 关：购买基金的高峰期
SELECT
    t3.t as pro_purchase_time,
    t3.amount as total_amount
FROM
    (
        SELECT
            *,
            COUNT(*) OVER (
                PARTITION BY t2.workday - t2.rownum
            ) cnt
        FROM
            (
                SELECT
                    *,
                    row_number() OVER (
                        ORDER BY
                            workday
                    ) rownum
                FROM
                    (
                        SELECT
                            pro_purchase_time t,
                            SUM(pro_quantity * f_amount) amount,
                            @row := datediff(
                                pro_purchase_time,
                                "2021-12-31"
                            ) - 2 * week(pro_purchase_time) workday
                        FROM
                            property,
                            fund,
                            (
                                SELECT
                                    @row
                            ) a
                        WHERE
                            pro_purchase_time LIKE "2022-02-%"
                            AND pro_type = 3
                            AND pro_pif_id = f_id
                        GROUP BY
                            pro_purchase_time
                    ) t1
                WHERE
                    amount > 1000000
            ) t2
    ) t3
WHERE
    t3.cnt >= 3;