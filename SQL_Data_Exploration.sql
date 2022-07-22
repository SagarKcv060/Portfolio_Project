select * from CovidDeaths$
order by 3,4;

select * from CovidVaccinations$
order by 3,4;

select location, date, new_cases, total_cases, total_deaths, population 
from CovidDeaths$
order by 1,2;

-- Looking at the Total cases and Total deaths
Select Location, date, Total_cases, Total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths$
where location like '%India%'
Where Continent is not null
order by DeathPercentage desc;

-- Looking for Total cases vs Population (What % of pop. got affected from Covid).
Select Location, date, Total_cases, population, (total_cases/population)*100 as DeathPercentage
from CovidDeaths$
where location like '%India%'
order by DeathPercentage desc;

-- Looking at Countries with highest Infection rate compared to population
select Location, population, MAX(Total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentPopulationInfected
from CovidDeaths$
--where location like '%asia%'
Where Continent is not null
group by Location, population
order by PercentPopulationInfected DESC;

-- SHOWING COUNTRIES WITH HIGHEST DEATH COUNT
SELECT LOCATION, MAX(Total_deaths) as TotalDeathCount
from CovidDeaths$
Where Continent is null
Group by location
Order by TotalDeathCount DESC;

SELECT LOCATION, MAX(cast(Total_deaths as int)) as TotalDeathCount
from CovidDeaths$
Where Continent is not null
Group by location
Order by TotalDeathCount DESC;

-- LET'S BREAKDOWN BY CONTINENT

SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from CovidDeaths$
Where Continent is not null
Group by continent
Order by TotalDeathCount DESC;

-- GLOBAL NUMBERS total deaths starting from 26.02.2020

SELECT DATE, SUM(new_cases) as Total_cases, SUM(CAST(new_deaths as int)) as Total_deaths, 
SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as Deathpercentage
from CovidDeaths$
where continent is not null
Group By date
order by 1,2

SELECT SUM(new_cases) as Total_cases, SUM(CAST(new_deaths as int)) as Total_deaths, 
SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as Deathpercentage
from CovidDeaths$
where continent is not null
--Group By date
order by 1,2

-- JOINING
-- Looking at Total Population vs Vaccinations

SELECT * FROM 
CovidDeaths$ DEA
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location)
FROM CovidDeaths$ DEA
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location ORDER BY dea.location, dea.date)
as CumulativePeoplevaccinated FROM CovidDeaths$ DEA
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location ORDER BY dea.location, dea.date)
as CumulativePeoplevaccinated FROM CovidDeaths$ DEA 
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--USE CTE TABLE
WITH PopvsVac (continent, Location, date, Population, new_vaccinations, CumulativePeoplevaccinated) 
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location ORDER BY dea.location, dea.date)
as CumulativePeoplevaccinated 
FROM CovidDeaths$ DEA 
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (CumulativePeoplevaccinated/population)*100
from Popvsvac


-- TEMP TABLE

DROP Table IF exists #PercentPopulationcaccinated
Create Table  #PercentPopulationcaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
Population numeric,
new_vaccinations numeric,
CumulativePeoplevaccinated numeric
)
Insert into #PercentPopulationcaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location ORDER BY dea.location, dea.date)
as CumulativePeoplevaccinated 
FROM CovidDeaths$ DEA 
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3
select *, (CumulativePeoplevaccinated/population)*100
from #PercentPopulationcaccinated

-- CREATING VIEWS

Create View PercentPopulationcaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) over (partition by dea.location ORDER BY dea.location, dea.date)
as CumulativePeoplevaccinated 
FROM CovidDeaths$ DEA 
JOIN 
CovidVaccinations$ VAC ON
	dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


select * from PercentPopulationcaccinated




