create table orders(
	order_id int primary key,
	customer_name nvarchar(255),
	order_date date
);

insert into orders
values 
	(1, 'Anna', '2025-06-25');

select * from orders;

alter table orders
drop constraint [PK__orders__46596229C8F22361];
