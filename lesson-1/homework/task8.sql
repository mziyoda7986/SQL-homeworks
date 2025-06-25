create table books(
	book_id int primary key identity,
	title nvarchar(255) check (title != ''),
	price decimal(10,2) check (price > 0),
	genre nvarchar(255) default 'Unkown'
);

insert into books(title, price)
values 
	('smth', 12.2);

insert into books
values 
	(' ', 5, 'horror');

insert into books
values 
	('smth', -5, 'horror');


select * from books