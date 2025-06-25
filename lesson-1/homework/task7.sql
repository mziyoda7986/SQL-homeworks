create table invoice(
	invoice_id int identity,
	amount decimal(10,2)
);

insert into invoice
values 
	(12.2),
	(4.3),
	(123.23),
	(9.9),
	(10.01);

select * from invoice;

set IDENTITY_INSERT invoice ON;

insert into invoice(invoice_id, amount)
values
	(100, 2.2);