drop table if exists data_types_demo;
create table data_types_demo(
	id uniqueidentifier,
	name nvarchar(255),
	price decimal(10,2),
	date_time datetime,
);

insert into data_types_demo
values
	(NEWID(), 'Anna', 12.87, GETDATE());

select * from data_types_demo;