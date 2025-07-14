drop table if exists Shipments;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);

--select sum(Num)/2 Median from (
--    select ROW_NUMBER() over(order by Num) rn, N, Num
--    from (
--        select * from Shipments
--            union all
--        select Row_number() over(order by (select null)) N, 0 Num
--        from string_split(
--            Replicate(',',40-(select count(*)from Shipments)-1), ',', 1)
--    ) t1
--) t2
--where rn = 20 or rn = 21;

;with Numbers as(
    select 1 as N
    union all
    select n+1 from Numbers where n+1<=40
),
AllDays as(
    select 
        n1.N,
        ISNULL(s.Num, 0) as Num
    from Numbers n1
    left join Shipments s on s.N = n1.N
)
select avg(Num) Median
from (
    select Num,
        ROW_NUMBER() over(order by Num) as rn
    from AllDays
) t
where rn in (20, 21)
