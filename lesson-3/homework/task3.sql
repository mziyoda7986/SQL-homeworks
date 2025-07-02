select *,
	iif (Stock = 0, 'Out of Stock',
		iif (Stock between 1 and 10, 'Low Stock', 'In Stock'))
	as StockStatus
from Products p1
where Price = (
	select max(Price)
	from Products p2
	where p1.Category = p2.Category
)
order by Price desc
offset 5 rows;