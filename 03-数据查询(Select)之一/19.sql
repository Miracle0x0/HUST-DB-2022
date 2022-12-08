-- 第 19 关：以日历表格式现实每日基金购买总金额
SELECT
    wk week_of_trading,
    SUM(if(dayId = 0, amount, null)) Monday,
    SUM(if(dayId = 1, amount, null)) Tuesday,
    SUM(if(dayId = 2, amount, null)) Wednesday,
    SUM(if(dayId = 3, amount, null)) Thursday,
    SUM(if(dayId = 4, amount, null)) Friday
FROM
    (
        SELECT
            week(pro_purchase_time) - 5 wk,
            weekday(pro_purchase_time) dayId,
            SUM(pro_quantity * f_amount) amount
        FROM
            property
            JOIN fund ON pro_pif_id = f_id
        WHERE
            pro_purchase_time LIKE "2022-02-%"
            AND pro_type = 3
        GROUP BY
            pro_purchase_time
    ) tmp
GROUP BY
    wk;