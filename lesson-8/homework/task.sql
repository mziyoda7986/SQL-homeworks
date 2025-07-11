-- 1
DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');


select
	min(StepNumber) as MinStepNumber,
	max(StepNumber) as MaxStepNumber,
	Status,
	Count(*) as ConsecutiveCount
from (
	select StepNumber,
		Status,
		sum(grouped) over(order by StepNumber rows unbounded preceding) BlockID
	from (
		select StepNumber,
			Status,
			case
				when Status != LAG(Status) over(order by StepNumber)
				or LAG(Status) over(order by StepNumber) is Null 
				then 1 else 0
			end grouped
		from Groupings
	) sub1
) sub2
group by BlockID, Status
order by MIN(StepNumber);



-- 2
DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');

select
	case
		when preHired is Null
		or YearHired - preHired <= 1
		then Null 
		else cast(preHired + 1 as varchar(4)) + ' - ' + CAST(YearHired - 1 as varchar(4))
	end Years
from(
	select Num,
		Year(Hire_date) YearHired,
		LAG(Year(Hire_date)) over(order by Num) preHired
	from (
		select
			ROW_NUMBER() over(order by Hire_date) as Num,
			*
		from EMPLOYEES_N
		where Year(Hire_date) > '1974'
	) sub1
) sub2
where not (preHired is Null
	or YearHired - preHired <= 1)

union all

select 
	CAST(Max_y + 1 as varchar(4)) + ' - ' + CAST(Year(GetDate()) as varchar(4)) as Years
from (
	select Max(Year(Hire_date)) Max_y 
	from EMPLOYEES_N
) last_year
where Max_y < year(GETDATE())