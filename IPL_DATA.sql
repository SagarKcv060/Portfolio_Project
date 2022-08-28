select top(20) * from IPL_Ball$;

select top(20) * from IPL_matches$;

select count(id) from IPL_Ball$;

select count(id) from IPL_matches$;

select distinct(city) from IPL_matches$;

select count(distinct(city)) from IPL_matches$;

select distinct(venue) from IPL_matches$;

select * from IPL_matches$
where date = '2013-05-02';

UPDATE IPL_matches$
SET result_margin = 0
WHERE result_margin is null;

select * from IPL_matches$
where result_margin > 100
order by result_margin desc;

select * from IPL_matches$
where result = 'tie'
order by date desc;


select *, 
case when total_runs >= 4 then 'BOUNDARY'
	when total_runs = 0 then 'Dot'
	else 'Other'
	end Ball_result
from IPL_Ball$

select * from IPL_Ball$

select total_runs, COUNT(total_runs) as MostBoundary from IPL_Ball$
group by total_runs
having total_runs >= 4;

select total_runs, COUNT(total_runs) as TotalDots from IPL_Ball$
group by total_runs
having total_runs = 0;

select total_runs, COUNT(total_runs) as TotalDots from IPL_Ball$
group by total_runs
having total_runs = 0;

select distinct(batting_team), total_runs from IPL_Ball$
where total_runs =6;