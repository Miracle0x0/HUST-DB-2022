-- 第 2 关：使用游标的存储过程
use hms1;

-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:

delimiter $$
create procedure sp_night_shift_arrange(in start_date date, in end_date date)
begin
    declare done int default false;
    declare tp, wk int default false;
    declare doctor, nurse1, nurse2 char(30);
    declare pointer char(30);
    declare nur_name cursor for select e_name from employee where e_type = 3;
    declare doc_type cursor for select e_type, e_name from employee where e_type != 3;
    declare continue handler for not found set done = true;

    open nur_name;
    open doc_type;

    while start_date <= end_date do
        fetch nur_name into nurse1;
        if done then
            close nur_name;
            open nur_name;
            set done = false;
            fetch nur_name into nurse1;
        end if;

        fetch nur_name into nurse2;
        if done then
            close nur_name;
            open nur_name;
            set done = false;
            fetch nur_name into nurse2;
        end if;

        set wk = weekday(start_date);
        if wk = 0 and pointer is not null then
            set doctor = pointer;
            set pointer = null;
        else
            fetch doc_type into tp, doctor;
            if done then
                close doc_type;
                open doc_type;
                set done = false;
                fetch doc_type into tp, doctor;
            end if;

            if wk > 4 and tp = 1 then
                -- 轮到主任周末夜班，用主任后面的医生递补
                set pointer = doctor;
                fetch doc_type into tp, doctor;
                if done then
                    close doc_type;
                    open doc_type;
                    set done = false;
                    fetch doc_type into tp, doctor;
                end if;
            end if;
        end if;

        insert into night_shift_schedule values (start_date, doctor, nurse1, nurse2);
        set start_date = date_add(start_date, interval 1 day);
    end while;

end$$

delimiter ;
