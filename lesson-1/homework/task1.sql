create database class1;
use class1;
drop table if exists student;
create table student(
	id int not null,
	name nvarchar(255),
	age int
);
insert into student
values 
	(1, 'Anna', 18),
	(2, 'John', null);

select * from student

alter table student
alter column id int null;

insert into student
values
	(null, 'Smith', 19)