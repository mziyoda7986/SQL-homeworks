-- 1
drop table if exists Employees;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

;with Emp as (
	select EmployeeID,
		ManagerID,
		JobTitle,
		0 as Depth
	from Employees
	where ManagerID is Null

	union all

	select e1.EmployeeID,
		e1.ManagerID,
		e1.JobTitle,
		e2.Depth + 1 as Depth
	from Employees e1
	inner join Emp e2
		on e1.ManagerID = e2.EmployeeID
)

select *
from Emp
order by EmployeeID;


-- 2
;with fc as(
	select 1 Num, 1 Factorial
		union all
	select Num + 1, Factorial * (Num + 1)
	from fc
	where Num < 10
)
select *
from fc
order by Num;


-- 3
;with fb as(
	select 1 n, 1 Fibonacci_Number, 0 preFb
		union all
	select n + 1, Fibonacci_Number + preFb, Fibonacci_Number
	from fb
	where n < 10
)
select n,
	Fibonacci_Number
from fb
order by n;