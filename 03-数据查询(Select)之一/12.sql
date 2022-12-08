-- 第 12 关：客户理财、保险与基金投资总额
SELECT
    c_name,
    c_id_card,
    ifnull(sum(pro_amount), 0) as total_amount
FROM
    client
    LEFT JOIN (
        (
            SELECT
                pro_c_id,
                pro_quantity * p_amount as pro_amount
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
                pro_quantity * i_amount as pro_amount
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
                pro_quantity * f_amount as pro_amount
            FROM
                property,
                fund
            WHERE
                pro_pif_id = f_id
                and pro_type = 3
        )
    ) pro ON pro.pro_c_id = c_id
GROUP BY
    c_id
ORDER BY
    total_amount desc;