-- 第 2 关：创建表及表的主码约束
CREATE DATABASE TestDb;

use TestDb;

CREATE TABLE t_emp(
    id INT PRIMARY KEY,
    deptId INT,
    name VARCHAR(32),
    salary FLOAT
);