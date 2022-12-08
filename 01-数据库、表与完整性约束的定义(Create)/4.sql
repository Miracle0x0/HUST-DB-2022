-- 第 4 关：CHECK 约束
DROP DATABASE MyDb;

CREATE DATABASE MyDb;

USE MyDb;

CREATE TABLE products(
    pid CHAR(10) PRIMARY KEY,
    name VARCHAR(32),
    brand CHAR(10) constraint CK_products_brand check(brand in ('A', 'B')),
    price INT constraint CK_products_price check(price > 0)
);