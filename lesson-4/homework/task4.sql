create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

-- 'b' first
select letter
from letters
order by 
	case when letter = 'b' then 0 else 1 end,
	letter;

-- 'b' last
select letter
from letters
order by 
	case when letter <> 'b' then 0 else 1 end,
	letter;


-- Place 'b' as the 3rd letter

select letter
from (
	select letter
	from letters
	where letter <> 'b'
	order by letter
	offset 0 row fetch next 2 rows only
) as top_part

union all

select letter
from letters
where letter = 'b'

union all

select letter
from (
	select letter
	from letters
	where letter <> 'b'
	order by letter
	offset 2 rows
) as bottom_part;