-- 1
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


create table #EmployeeTransfers (
    EmployeeID int primary key,
    Name varchar(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
select
    EmployeeID,
    Name,
    case 
        when Department = 'HR' then 'IT'
        when Department = 'IT' then 'Sales'
        when Department = 'Sales' then 'HR'
        else Department
    end,
    Salary
from Employees

select * from #EmployeeTransfers


-- 2
CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

declare @MissingOrders table (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

insert into @MissingOrders
select o1.*
from Orders_DB1 o1
left join Orders_DB2 o2
    on o1.OrderID = o2.OrderID
where o2.OrderID is null

select * from @MissingOrders


-- 3
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

drop view if exists vw_MonthlyWorkSummary;
create view vw_MonthlyWorkSummary as
    select
        EmployeeName as Info, 
        Department, 
        SUM(HoursWorked) as Value
    from WorkLog
    group by EmployeeName, Department

    union all

    select 'TotalHoursDepartment' as Info,
        Department as info2_Department,
        SUM(HoursWorked) as Value
    from WorkLog
    group by Department

    union all 

    select 'AvgHoursDepartment' as Info,
        Department as info3_Department,
        AVG(HoursWorked * 1.0) as Value
    from WorkLog
    group by Department;


select * from vw_MonthlyWorkSummary