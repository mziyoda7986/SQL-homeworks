create table worker(
	id int,
	name nvarchar(255)
);

bulk insert worker
from 'C:\Users\Lenovo PC\Desktop\MAAB\SQL\SQL-homeworks\lesson-2\homework\worker.csv'
with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator='\n'
);

select * from worker