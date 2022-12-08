-- 第 13 关：客户总资产
SELECT
    c_id,
    c_name,
    ifnull(SUM(amount), 0) as total_property
FROM
    client
    LEFT JOIN(
        (
            SELECT
                pro_c_id,
                pro_quantity * p_amount as amount
            FROM
                property,
                finances_product
            WHERE
                pro_pif_id = p_id
                AND pro_type = 1
        )
        UNION
        ALL (
            SELECT
                pro_c_id,
                pro_quantity * i_amount as amount
            FROM
                property,
                insurance
            WHERE
                pro_pif_id = i_id
                AND pro_type = 2
        )
        UNION
        ALL (
            SELECT
                pro_c_id,
                pro_quantity * f_amount as amount
            FROM
                property,
                fund
            WHERE
                pro_pif_id = f_id
                AND pro_type = 3
        )
        UNION
        ALL (
            SELECT
                pro_c_id,
                SUM(pro_income) as amount
            FROM
                property
            GROUP BY
                pro_c_id
        )
        UNION
        ALL (
            SELECT
                b_c_id,
                SUM(
                    if (
                        b_type = '储蓄卡',
                        b_balance,
                        - b_balance
                    )
                ) as amount
            FROM
                bank_card
            GROUP BY
                b_c_id
        )
    ) pro ON c_id = pro.pro_c_id
GROUP BY
    c_id
ORDER BY
    c_id;