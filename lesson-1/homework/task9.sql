create table Book(
	book_id int primary key,
	title nvarchar(255),
	author nvarchar(255),
	published_year int
);

create table Member(
	member_id int primary key,
	name nvarchar(255),
	email nvarchar(255),
	phone_number nvarchar(255)
);

create table Loan(
	loan_id int primary key,
	book_id int foreign key references book(book_id),
	member_id int foreign key references member(member_id),
	loan_date date,
	return_date date null
);

insert into Book
values
	(1, 'IT', 'Stephen King', 1970),
	(2, 'Martin Iden', 'Jack London', 1909)

insert into Member
values
	(1, 'Anna', null, '998099009'),
	(2, 'Bob', 'bob@gmail.com', null);

insert into Loan
values
	(1, 2, 1, '2025-01-01', null),
	(2, 1, 2, '2025-06-01', '2025-06-07');

select * from Book;
select * from Member;
select * from Loan;