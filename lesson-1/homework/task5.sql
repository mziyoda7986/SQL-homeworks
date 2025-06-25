create table account(
	account_id int primary key,
	balance decimal(10,2) check (balance>=0),
	account_type nvarchar(255) check (account_type in ('Saving', 'Checking'))
);

alter table account drop constraint [CK__account__account__4AB81AF0];
alter table account drop constraint CK__account__balance__49C3F6B7;

alter table account
add check (balance>=0);

alter table account
add check (account_type in ('Saving', 'Checking'));