describe Students;
show create table Students;

create table if not exists Students
(
    id         int          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name  varchar(128) NOT NULL,
    age        int(3) check ( age >= 17 AND age <= 40 )
);

alter table Students
    modify age tinyint unsigned;

insert into `091224ptm-MaksymM`.Students (first_name, last_name, age)
select `students`.`Students`.name, `students`.`Students`.name, `students`.`Students`.age
from `students_1K`.`Student`;

insert into `091224ptm-MaksymM`.Students (first_name, last_name, age)
select `students_1K`.`Student`.first_name, `students_1K`.`Student`.last_name, NULL
from `students_1K`.`Student`;

select * from `students_1K`.Student;
