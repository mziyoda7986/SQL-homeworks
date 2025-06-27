create table student(
	classes int,
	tuition_per_class decimal(10,2),
	total_tuition as (classes * tuition_per_class)
);

insert into student
values 
	(4, 1.2),
	(10, 2.2),
	(2, 5.4);

select * from student;