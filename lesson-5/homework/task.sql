CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

-- 1
select *, 
ROW_NUMBER() over(order by Salary desc) as rank_salary
from Employees
order by EmployeeID;

-- 2
select *
from (
    select *,
    dense_rank() over(order by Salary) as rank_salary
    from Employees
) t
where rank_salary in(
    select rank_salary
    from(
        select
        dense_rank() over(order by Salary) as rank_salary
        from Employees
    ) InnerRanked
    group by rank_salary
    having count(*) > 1
);

-- 3
select *
from (
    select *,
    row_number() over(partition by Department order by Salary desc) as rank_salary
    from Employees
) t
where rank_salary <= 2;

-- 4
select *
from Employees e
where salary = (
    select min(Salary)
    from Employees
    where Department = e.Department
);

-- 5
select *,
sum(Salary) over(partition by Department) as TotalDepartment
from Employees;

-- 6
select *,
sum(Salary) over(partition by Department) as TotalDepartment
from Employees;

-- 7
select *,
cast(avg(salary) over(partition by Department) as decimal(10, 2)) as avgDepartment
from Employees;

-- 8
select *,
cast(avg(salary) over(partition by Department) as decimal(10, 2)) - Salary as Difference
from Employees;

-- 9
select *,
avg(Salary) over(order by EmployeeID rows between 1 preceding and 1 following)
from Employees;

-- 10
select sum(Salary) as SumSalary_Last3Hired
from (
    select *,
    row_number() over(order by HireDate desc) as rk
    from Employees
) t
where rk<=3;

-- 11
select *,
cast(avg(salary) over(order by EmployeeID) as decimal(10, 2)) as avgSalary
from Employees;

-- 12
select *,
max(Salary) over(order by EmployeeID rows between 2 preceding and 2 following) as maxSalary
from Employees;

-- 13
select *,
sum(Salary) over(partition by Department) as TotalSalary,
cast(Salary / sum(Salary) over(partition by Department) * 100 as decimal(10, 2)) as percSalary
from Employees;