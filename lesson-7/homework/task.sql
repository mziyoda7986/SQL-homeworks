drop table if exists Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

drop table if exists OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

-- 1
select * 
from Customers c
left join Orders o
    on o.CustomerID = c.CustomerID;

-- 2
select *
from Customers c
left join Orders o
    on o.CustomerID = c.CustomerID
where 
    case when o.OrderID is Null then 0 else 1 end = 0;

-- 3
select o.OrderID, od.OrderDetailID, p.ProductName, od.Quantity
from Orders o
join OrderDetails od
    on o.OrderID = od.OrderID
join Products p
    on od.ProductID = p.ProductID;

-- 4
select c.CustomerID,
    c.CustomerName
from Customers c
join Orders o
    on c.CustomerID = o.CustomerID
group by c.CustomerName, c.CustomerID
having count(c.CustomerID) > 1;

-- 5
select o.OrderID, max(od.Price) MaxPrice
from Orders o
join OrderDetails od
    on o.OrderID = od.OrderID
group by o.OrderID;

-- 6
select o.CustomerID, max(o.OrderDate)
from Orders o
join OrderDetails od
    on o.OrderID = od.OrderID
group by o.CustomerID;

-- 7    
select c.CustomerID, c.CustomerName
from Customers c
join Orders o
    on c.CustomerID = o.CustomerID
join OrderDetails od
    on o.OrderID = od.OrderID
join Products p
    on od.ProductID = p.ProductID
group by c.CustomerName, c.CustomerID
having count(distinct case when p.Category <> 'Electronics' then p.ProductID end) = 0;

-- 8
select c.CustomerID, c.CustomerName
from Customers c
join Orders o
    on c.CustomerID = o.CustomerID
join OrderDetails od
    on o.OrderID = od.OrderID
join Products p
    on od.ProductID = p.ProductID
group by c.CustomerName, c.CustomerID
having count(distinct case when p.Category = 'Stationery' then p.ProductID end) > 0;

-- 9
select c.CustomerID, c.CustomerName, sum(od.Price*od.Quantity) TotalSpent
from Customers c
join Orders o
    on c.CustomerID = o.CustomerID
join OrderDetails od
    on o.OrderID = od.OrderID
group by c.CustomerID, c.CustomerName;
