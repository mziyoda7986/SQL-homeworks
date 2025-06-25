create table customer(
	customer_id int primary key,
	name nvarchar(255),
	city nvarchar(255) default 'Unkown'
);

alter table customer drop constraint [DF__customer__city__5070F446];

alter table customer
add default 'Unkown' for city;