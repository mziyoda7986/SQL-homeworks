use class2;
create table test_identity(
	id int identity,
	name nvarchar(255)
);

insert into test_identity
values 
	('Anna'),
	('Bob'),
	('John'),
	('Smith'),
	('Kim');

select * from test_identity;

delete from test_identity;
truncate table test_identity;
drop table test_identity;

--(1) The next time it starts from where it left off. For example, if 5 rows were added and a new data is inserted after the DELETE, its id will start from 6.
--(2) The next time it starts from where it left off. For example, if 5 rows were added and a new data is inserted after the TRUNCATE, its id will start from 1.
--(3) It deletes the table completely. If we want to add information to the table, we will have to create the table again.
