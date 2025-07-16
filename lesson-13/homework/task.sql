declare @date date = '20241001';
declare @year int = Year(@date);
declare @month int = Month(@date);

declare @firstdate date = datefromparts(@year, @month, 1);
declare @lastdate date = eomonth(@firstdate);

;with Dates as (
	select @firstdate as CalendarDate
	union all
	select DATEADD(day, 1, CalendarDate)
	from Dates
	where CalendarDate < @lastdate
),
CalendarCTE as (
	select
		CalendarDate,
		DENSE_RANK() OVER (ORDER BY DATEADD(DAY, - DATEPART(WEEKDAY, CalendarDate) + 1, CalendarDate)) AS WeekNum,
		DATEPART(weekday, CalendarDate) as WeekDayNumber,
		day(CalendarDate) as DayOfMonth
	from Dates
)

select
	MAX(CASE WHEN WeekDayNumber = 1 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Sunday,
    MAX(CASE WHEN WeekDayNumber = 2 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Monday,
    MAX(CASE WHEN WeekDayNumber = 3 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Tuesday,
    MAX(CASE WHEN WeekDayNumber = 4 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Wednesday,
    MAX(CASE WHEN WeekDayNumber = 5 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Thursday,
    MAX(CASE WHEN WeekDayNumber = 6 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Friday,
    MAX(CASE WHEN WeekDayNumber = 7 THEN RIGHT('  ' + CAST(DayOfMonth AS VARCHAR(2)), 2) ELSE Null END) AS Saturday
from CalendarCTE
group by WeekNum
order by WeekNum;