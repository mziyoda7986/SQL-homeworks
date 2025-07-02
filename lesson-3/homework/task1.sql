select Department, AVG(Salary) as AverageSalary,
case
    when AVG(Salary) > 80000 then 'High'
    when AVG(Salary) >= 50000 then 'Medium'
    else 'Low'
end as SalaryCategory
from(
    select top 10 percent *
    from Employees
    order by Salary desc
) as Top10Percent
group by Department
order by AVG(Salary) desc
offset 2 rows fetch next 5 rows only;