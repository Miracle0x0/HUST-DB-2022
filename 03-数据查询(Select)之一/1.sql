-- 第 1 关：金融应用场景介绍，查询客户主要信息
SELECT
    c_name,
    c_phone,
    c_mail
FROM
    client
ORDER BY
    c_id;