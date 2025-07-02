select 
	case
		when [Status] in ('Shipped', 'Delivered') then 'Completed'
		when [Status] = 'Pending' then 'Pending'
		else 'Cancelled'
	end as OrderStatus,
	count(*) as TotalOrders,
	sum(TotalAmount) as TotalRevenue
from Orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by
	case
		when [Status] in ('Shipped', 'Delivered') then 'Completed'
		when [Status] = 'Pending' then 'Pending'
		else 'Cancelled'
	end
having sum(TotalAmount) > 5000
order by sum(TotalAmount) desc;