-- 第 1 关：从概念模型到MySQL实现
drop DATABASE flight_booking;

CREATE DATABASE flight_booking;

use flight_booking;

-- 1. 用户 user
create table user (
    -- 用户编号: user_id int 主码,自动增加
    user_id int PRIMARY KEY auto_increment,
    -- 名字: firstname varchar(50) 不可为空
    firstname VARCHAR(50) NOT NULL,
    -- 姓氏: lastname varchar(50) 不可为空
    lastname VARCHAR(50) NOT NULL,
    -- 生日: dob date 不可为空
    dob DATE NOT NULL,
    -- 性别: sex char(1) 不可为空
    sex CHAR(1) NOT NULL,
    -- 邮箱: email varchar(50) 
    email VARCHAR(50),
    -- 联系电话: phone varchar(30)
    phone VARCHAR(30),
    -- 用户名: username varchar(20) 不可空,不可有重
    username VARCHAR(20) NOT NULL UNIQUE,
    -- 密码: password char(32) 不可空
    password CHAR(32) NOT NULL,
    -- 管理员标志: admin_tag tinyint 缺省值0(非管理员),不能空
    admin_tag TINYINT DEFAULT 0 NOT NULL
);

-- 2. 旅客 passenger
create table passenger (
    -- 旅客编号: passenger_id int 自增，主码
    passenger_id INT PRIMARY KEY auto_increment,
    -- 证件号码: id char(18) 不可空 不可重
    id CHAR(18) NOT NULL UNIQUE,
    -- 名字：firstname varchar(50) 不可空
    firstname VARCHAR(50) NOT NULL,
    -- 姓氏: lastname varchar(50) 不可空
    lastname VARCHAR(50) NOT NULL,
    -- 邮箱：mail varchar(50) 
    mail VARCHAR(50),
    -- 电话: phone varchar(20) 不可空
    phone VARCHAR(20) NOT NULL,
    -- 性别: sex char(1) 不可空
    sex CHAR(1) NOT NULL,
    -- 生日: dob date
    dob DATE
);

-- 3. 机场 airport
create table airport(
    -- 编号: airport_id int 自增，主码
    airport_id INT PRIMARY KEY auto_increment,
    -- 国际民航组织编码：iata char(3) 不可空，全球唯一
    iata CHAR(3) NOT NULL UNIQUE,
    -- 国际航运协会编码: icao char(4) 不可空，全球唯一
    icao CHAR(4) NOT NULL UNIQUE,
    -- 机场名称: name varchar(50) 不可空，普通索引
    name VARCHAR(50) NOT NULL,
    -- 所在城市: city varchar(50)
    city VARCHAR(50),
    -- 所在国家: country varchar(50)
    country VARCHAR(50),
    -- 纬度: latitude decimal(11,8)
    latitude DECIMAL(11, 8),
    -- 经度: longitude decimal(11,8)
    longitude DECIMAL(11, 8),
    -- 指定机场名称 name 为普通索引
    index(name)
);

-- 4. 航空公司 airline
create table airline (
    -- 编号：airline_id int 自增，主码
    airline_id INT PRIMARY KEY auto_increment,
    -- 名称：name varchar(30) 不可空
    name VARCHAR(30) NOT NULL,
    -- 国际民航组织编码: iata char(2) 不可空，具全球唯一性
    iata CHAR(2) NOT NULL UNIQUE,
    -- 
    airport_id INT NOT NULL,
    -- * 外码
    Foreign Key (airport_id) REFERENCES airport(airport_id)
);

-- 5. 名航飞机 airplane
create table airplane (
    -- 编号：airplane_id int 自增，主码
    airplane_id INT PRIMARY KEY auto_increment,
    -- 机型：type varchar(50) 不可空，如B737-300,A320-500等
    type VARCHAR(50) NOT NULL,
    -- 座位: capacity smallint 不可空
    capacity SMALLINT NOT NULL,
    -- 标识: identifier varchar(50) 不可空
    identifier VARCHAR(50) NOT NULL,
    -- 
    airline_id INT NOT NULL,
    -- 外码
    Foreign Key (airline_id) REFERENCES airline(airline_id)
);

-- 6. 航班常规调度表 flightschedule
create table flightschedule (
    -- 航班号: flight_no char(8) 主码
    flight_no CHAR(8) PRIMARY KEY,
    -- 起飞时间: departure time 非空
    departure TIME NOT NULL,
    -- 到达时间: arrival time 非空
    arrival TIME NOT NULL,
    -- 飞行时长: duration smalint 非空
    duration SMALLINT NOT NULL,
    -- 周一：monday tinyint 缺省0
    monday TINYINT DEFAULT 0,
    -- 周二：tuesday tinyint 缺省0
    tuesday TINYINT DEFAULT 0,
    -- 周三：wednesday tinyint 缺省0
    wednesday TINYINT DEFAULT 0,
    -- 周四：thursday tinyint 缺省0
    thursday TINYINT DEFAULT 0,
    -- 周五：friday tinyint 缺省0
    friday TINYINT DEFAULT 0,
    -- 周六：saturday tinyint 缺省0
    saturday TINYINT DEFAULT 0,
    -- 周日：sunday tinyint 缺省0
    sunday TINYINT DEFAULT 0,
    -- ! 例外处理
    airline_id INT NOT NULL,
    `from` INT NOT NULL,
    `to` INT NOT NULL,
    -- * 外码
    Foreign Key (airline_id) REFERENCES airline(airline_id),
    Foreign Key (`from`) REFERENCES airport(airport_id),
    Foreign Key (`to`) REFERENCES airport(airport_id)
);

-- 7. 航班表 flight
create table flight(
    -- 飞行编号：flight_id int 自增，主码
    flight_id INT PRIMARY KEY auto_increment,
    -- 起飞时间: departure datetime 非空
    departure datetime NOT NULL,
    -- 到达时间: arrival datetime 非空
    arrival datetime NOT NULL,
    -- 飞行时长：duration smallint 非空
    duration SMALLINT NOT NULL,
    -- ! 例外处理
    airline_id INT NOT NULL,
    airplane_id INT NOT NULL,
    flight_no CHAR(8) NOT NULL,
    `from` INT NOT NULL,
    `to` INT NOT NULL,
    -- * 外码
    Foreign Key (airline_id) REFERENCES airline(airline_id),
    Foreign Key (airplane_id) REFERENCES airplane(airplane_id),
    Foreign Key (flight_no) REFERENCES flightschedule(flight_no),
    Foreign Key (`from`) REFERENCES airport(airport_id),
    Foreign Key (`to`) REFERENCES airport(airport_id)
);

-- 8. 机票 ticket
create table ticket(
    -- 票号：ticket_id int 自增，主码
    ticket_id INT PRIMARY KEY auto_increment,
    -- 坐位号：seat char(4)
    seat CHAR(4),
    -- 价格：price decimal(10,2) 不能空
    price DECIMAL(10, 2) NOT NULL,
    -- ! 例外处理
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    user_id INT NOT NULL,
    -- * 外码
    Foreign Key (flight_id) REFERENCES flight(flight_id),
    Foreign Key (passenger_id) REFERENCES passenger(passenger_id),
    Foreign Key (user_id) REFERENCES user(user_id)
);