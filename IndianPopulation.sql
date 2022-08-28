select * from Data1;

select * from Data2;

select COUNT(*) from Data1;

select COUNT(*) from Data2;

-- dataset for jharkhand and bihar

select * from Data1 
WHERE state in ('jharkhand', 'Bihar');

--Population of INDIA

select SUM(Population) AS TotalPopulation from Data2 

-- AVG Growth

select State, ROUND(AVg(Growth)*100, 2) AS AVG_growth from Data1
Group by State;

-- AVG Sex ratio

select state, ROUND(AVG(Sex_ratio), 0) AS Avg_Sex_ratio from Data1
GROUP BY State
ORDER BY Avg_Sex_ratio DESC;

-- AVG Literacy ratio

SELECT STATE, ROUND(AVG(literacy), 0) AS AVG_Literacy_ratio 
from Data1
GROUP BY State
HAVING ROUND(AVG(literacy), 0) > 85
ORDER BY AVG_Literacy_ratio DESC; 

-- Top 3 state showing highest growth ratio

SELECT TOP 3 STATE, AVg(Growth)*100 AS AVG_growth FROM Data1
GROUP BY STATE
ORDER BY AVG_growth DESC

-- Bottom 3 state showing lowest sex ratio

SELECT TOP 3 STATE, ROUND(AVG(Sex_ratio), 0) AS Avg_Sex_ratio FROM Data1
GROUP BY STATE
ORDER BY Avg_Sex_ratio ASC

-- Top and Bottom 3 states in literacy state

DROP TABLE IF EXISTS #Top_states;
CREATE TABLE #Top_states
( State nvarchar(255),
  Topstates float
  )

INSERT INTO #Top_states 
SELECT STATE, ROUND(AVG(literacy), 0) AS AVG_Literacy_ratio FROM Data1
GROUP BY STATE
ORDER BY AVG_Literacy_ratio DESC;

SELECT top 3 * from #Top_states
ORDER BY #Top_states.Topstates desc;


DROP TABLE IF EXISTS #bottom_states;
CREATE TABLE #bottom_states
( State nvarchar(255),
  Topstates float
  )

INSERT INTO #bottom_states 
SELECT STATE, ROUND(AVG(literacy), 0) AS AVG_Literacy_ratio FROM Data1
GROUP BY STATE
ORDER BY AVG_Literacy_ratio DESC;

SELECT top 3 * from #bottom_states
ORDER BY #bottom_states.Topstates asc;

-- UNION OPERATOR

SELECT * FROM (SELECT top 3 * from #Top_states
ORDER BY #Top_states.Topstates desc) a
UNION
SELECT * FROM (SELECT top 3 * from #bottom_states
ORDER BY #bottom_states.Topstates asc) b;

-- states starting with letter a

SELECT distinct State FROM Data1
WHERE LOWER(STATE) LIKE 'a%';


SELECT distinct State FROM Data1
WHERE LOWER(STATE) LIKE 'a%' or LOWER(state) like 'm%';

SELECT distinct State FROM Data1
WHERE LOWER(STATE) LIKE 'a%' or LOWER(state) like '%d';

SELECT distinct State FROM Data1
WHERE LOWER(STATE) LIKE 'a%' and LOWER(state) like '%d';

SELECT distinct State FROM Data1
WHERE LOWER(STATE) LIKE 'a%' and LOWER(state) like '%m';

--
SELECT a.District, a.State, a.Sex_Ratio, b.Population FROM Data1 a
JOIN
Data2 b on a.District = b.District

select c.district, c.State, round(c.Population/(c.sex_ratio+1),0) as MALES, round(c.Population*c.sex_ratio/(c.sex_ratio+1),0) as FEMALES from
(SELECT a.District, a.State, a.Sex_Ratio/1000 as sex_ratio, b.Population FROM Data1 a
JOIN
Data2 b on a.District = b.District) c


select d.State, sum(d.MALES) as TotalMales, sum(d.FEMALES) as TotalFeamles from
(select c.district, c.State, round(c.Population/(c.sex_ratio+1),0) as MALES, round(c.Population*c.sex_ratio/(c.sex_ratio+1),0) as FEMALES from
(SELECT a.District, a.State, a.Sex_Ratio/1000 as sex_ratio, b.Population FROM Data1 a
JOIN
Data2 b on a.District = b.District) c) d
group by d.State;


select f.State, sum(f.LiteratePeople) as TotalLiterate, sum(f.Illiterate) as TotalIlleterae from
(select e.District, e.State, round(e.Literacy_ratio*e.Population,0) as LiteratePeople, round((1-e.Literacy_ratio)*e.Population,0) as Illiterate from
(SELECT a.District, a.State, a.Literacy/100 as Literacy_ratio, b.Population FROM Data1 a
JOIN
Data2 b on a.District = b.District) e) f
group by f.State;

