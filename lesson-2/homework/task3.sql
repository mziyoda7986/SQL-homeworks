create table photos(
	id int,
	photo varbinary(max)
);

insert into photos
select 1, BulkColumn from openrowset(
	Bulk 'C:\Users\Lenovo PC\Desktop\MAAB\SQL\SQL-homeworks\lesson-2\homework\images.jpg', single_blob
) as img;
SELECT @@SERVERNAME;
select * from photos;