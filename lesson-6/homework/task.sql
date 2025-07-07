CREATE TABLE Departments (
    DepartmentID INT,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT,
    Name VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

CREATE TABLE Projects (
    ProjectID INT,
    ProjectName VARCHAR(50),
    EmployeeID INT
);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

select * from Departments;
select * from Employees;
select * from Projects;

-- 1
select *
from Employees as e
inner join Departments as d
    on e.DepartmentID = d.DepartmentID;

-- 2
select *
from Employees as e
left join Departments as d
    on e.DepartmentID = d.DepartmentID;

-- 3
select *
from Employees e
right join Departments d
    on e.DepartmentID = d.DepartmentID;

-- 4
select *
from Employees e
full join Departments d
    on e.DepartmentID = d.DepartmentID;

-- 5
select d.DepartmentName,
    sum(e.Salary) as TotalSalary
from Employees e
right join Departments d
    on e.DepartmentID = d.DepartmentID
group by d.DepartmentName;

-- 6
select *
from Employees e
cross join Departments d;

-- 7
select *
from Employees e
left join Departments d
    on e.DepartmentID = d.DepartmentID
left join Projects p
    on e.EmployeeID = p.EmployeeID;