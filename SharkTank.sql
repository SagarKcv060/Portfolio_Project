select * from SharkTank

-- Total Episodes

Select distinct [Ep# No#] from SharkTank;
Select count(distinct [Ep# No#]) from SharkTank;

select max([Ep# No#]) from SharkTank;

-- Pitches

select count(distinct brand) from SharkTank;

select Brand, Deal, [Amount Invested lakhs] from SharkTank
where [Amount Invested lakhs]>0
order by [Amount Invested lakhs] desc;

select count([Amount Invested lakhs]) as TotalPitches from sharktank

select count([Amount Invested lakhs]) as FundingRecieved from sharktank
where [Amount Invested lakhs]>0;
 
-- Total male and female

select sum(male) from SharkTank

select sum(Female) from SharkTank

select round(sum(female)/sum(male), 4)*100 from SharkTank;

-- Total amount invested

select sum([Amount Invested lakhs]) from SharkTank

-- AVg Equity taken

select round(AVG(a.[Equity Taken %]),2) from 
(select * from SharkTank
where [Equity Taken %]>0) a

-- hidhest deal taken

select MAX([Amount Invested lakhs]) from SharkTank	

-- Highest Equity taken

select max([Equity Taken %]) from SharkTank

--Startups having atleast women

SELECT sum(a.female_count) from
(select Female, CASE WHEN Female>0 THEN 1 ELSE 0 
END AS FEMALE_COUNT from SharkTank) a;

--Pitches converted having atleast women

select * from SharkTank

select sum(b.female_count) as Totalwomencount from
(select case when a.female>0 then 1 else 0 end as female_count, a.*from(
(select * from SharkTank where Deal != 'No Deal')) a) b;

-- AVG Team members

select ROUND(AVG([Team members]),2) from SharkTank

--Amount invested per deal

select AVG(a.[Amount Invested lakhs]) as amountInvestedPerDeal from
(select * from SharkTank where Deal != 'No Deal') a;

--AVG age group of contestants 

select [Avg age], count([Avg age]) from SharkTank
group by [Avg age]
order by count([Avg age]) desc;

--Location of group of contestants 

select Location, count(Location) from SharkTank
group by Location
order by count(Location) desc;

--Sector of group of contestants 

select Sector, count(Sector) from SharkTank
group by Sector
order by count(Sector) desc;

--Partner deals

select Partners, COUNT(partners) cnt from SharkTank 
where Partners != '-'
group by Partners
order by cnt desc;

--Making the matrix

select [Ashneer Amount Invested] from SharkTank
where [Ashneer Amount Invested] is not null

select count([Ashneer Amount Invested]) from SharkTank
where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0;
 
select 'Ashneer' as keyy, sum(c.[Ashneer Amount Invested]), round(AVg(c.[Ashneer Equity Taken %])*100, 4) 
 from (select * from SharkTank 
where [Ashneer Equity Taken %] !=0 and [Ashneer Equity Taken %] is not null) c;


select a.keyy, a.TotalDealsPresent, b.Totaldeals from
(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) TotalDealsPresent
from SharkTank
where [Ashneer Amount Invested] is not null) a

Inner Join

(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) TotalDeals
from SharkTank
where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0) b

on a.keyy = b.keyy;

---

select m.keyy, m.TotalDealsPresent, m.Totaldeals, n.TotalAmountinvested, n.AVGEquitytaken
from

(select a.keyy, a.TotalDealsPresent, b.Totaldeals from
(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) TotalDealsPresent
from SharkTank
where [Ashneer Amount Invested] is not null) a

Inner Join

(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) TotalDeals
from SharkTank
where [Ashneer Amount Invested] is not null AND [Ashneer Amount Invested] != 0) b

on a.keyy = b.keyy) m

Inner Join

(select 'Ashneer' as keyy, sum(c.[Ashneer Amount Invested]) TotalAmountinvested, 
round(AVg(c.[Ashneer Equity Taken %])*100, 4) AVGEquitytaken 
 from (select * from SharkTank 
where [Ashneer Equity Taken %] !=0 and [Ashneer Equity Taken %] is not null) c) n

on m.keyy = n.keyy;

--
select Brand, Sector, [Amount Invested lakhs], rank() over(partition by Sector  
order by [Amount Invested lakhs] desc) rnk from SharkTank

select c.* from
(select Brand, Sector, [Amount Invested lakhs], rank() over(partition by Sector  
order by [Amount Invested lakhs] desc) rnk from SharkTank) c
where c.rnk = 1;