-- 1

declare @i int = 1;
declare @count int;
declare @name varchar(50);
select @count = count(1)
	from sys.databases
	where name not in ('master', 'tempdb', 'model', 'msdb');
declare @sql varchar(max);
drop table if exists #sql_Table;
	create table #sql_table(
		DatabaseName nvarchar(255),
		SchemaName nvarchar(255),
		TableName nvarchar(255),
		ColumnName nvarchar(255),
		DataType nvarchar(255)
	);


while @i <= @count
begin
	;with cte as(
		select ROW_NUMBER() over(order by name) rn, name
		from sys.databases
		where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name = name from cte
	where rn = @i;

	set @sql = '
	USE [' + @name + '];
	select TABLE_CATALOG DatabaseName,
		TABLE_SCHEMA SchemaName,
		TABLE_NAME TableName,
		COLUMN_NAME ColumnName,
		CONCAT(
			DATA_TYPE, 
			case 
				when ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')'' = ''(-1)''
				then ''(max)''
				else ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')''
			end
			) DataType
	from INFORMATION_SCHEMA.COLUMNS;'

	insert into #sql_table
		exec (@sql);
	set @i = @i + 1;
end;

select * from #sql_table;


-- 2
select * 
from Information_schema.PARAMETERS
go
create procedure sp_ListProcedureAndPuctions
	@DatabaseName varchar(255) = Null
as
begin
	set nocount on;
	declare @sql nvarchar(max)

	drop table if exists #sql_Table;
	create table #sp_sql_table(
		DatabaseName nvarchar(255),
		SchemaName nvarchar(255),
		RoutineName nvarchar(255),
		ParameterName nvarchar(255),
		ParameterDataType nvarchar(255)
	);

	if @DatabaseName is not null
	begin
		set @sql = '
			USE [' + @DatabaseName + '];
			select ''' + @DatabaseName + ''' DatabaseName,
				SPECIFIC_SCHEMA AS SchemaName,
                SPECIFIC_NAME AS RoutineName,
                PARAMETER_NAME AS ParameterName,
				CONCAT(
					DATA_TYPE, 
					case 
						when ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')'' = ''(-1)''
						then ''(max)''
						else ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')''
					end
					) ParameterDataType
			from INFORMATION_SCHEMA.PARAMETERS;'

			insert into #sp_sql_table
				exec (@sql);
	end
	else
	begin
		declare @i int = 1;
		declare @count int;
		declare @name varchar(50);
		select @count = count(1)
			from sys.databases
			where name not in ('master', 'tempdb', 'model', 'msdb');

		while @i <= @count
		begin
			;with cte as(
				select ROW_NUMBER() over(order by name) rn, name
				from sys.databases
				where name not in ('master', 'tempdb', 'model', 'msdb')
			)
			select @name = name from cte
			where rn = @i;

			set @sql = '
			USE [' + @name + '];
			select ''' + @name + ''' DatabaseName,
				SPECIFIC_SCHEMA AS SchemaName,
                SPECIFIC_NAME AS RoutineName,
                PARAMETER_NAME AS ParameterName,
				CONCAT(
					DATA_TYPE, 
					case 
						when ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')'' = ''(-1)''
						then ''(max)''
						else ''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(50)) + '')''
					end
					) ParameterDataType
			from INFORMATION_SCHEMA.PARAMETERS;'

			insert into #sp_sql_table
				exec (@sql);
			set @i = @i + 1;
		end
	end
	select * from #sp_sql_table
end;

exec sp_ListProcedureAndPuctions;