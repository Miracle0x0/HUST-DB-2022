-- 第 3 关：创建外码约束（foreign key）
DROP DATABASE MyDb;

CREATE DATABASE MyDb;

USE MyDb;

CREATE TABLE dept (
    deptNo INT PRIMARY KEY,
    deptName VARCHAR(32)
);

CREATE TABLE staff(
    staffNo INT PRIMARY KEY,
    staffName VARCHAR(32),
    gender CHAR(1),
    dob DATE,
    salary numeric(8, 2),
    deptNo INT,
    constraint FK_staff_deptNo FOREIGN KEY(deptNo) REFERENCES dept(deptNo)
);