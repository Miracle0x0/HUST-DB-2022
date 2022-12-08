-- 第 4 关：幻读
-- READ_ONLY
-- 事务2（采用默认的事务隔离级别- repeatable read）:
use testdb1;
start transaction;
set @n = sleep(1);
insert into ticket values('MU5111','A330-200',311);
commit;