drop table if exists product;
create table product(
	product_id int unique,
	product_name nvarchar(255),
	price decimal(10, 2)
);

insert into product
values
	(1, 'smth', 1.7);

select * from product

alter table product
drop constraint [UQ__product__47027DF453454F33];
