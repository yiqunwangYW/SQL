--# Nested select
--# List each country and its continent in the same continent as 'Brazil' or 'Mexico'.
SELECT name, continent FROM world
WHERE continent IN
  (SELECT continent FROM world WHERE name='Brazil' OR name='Mexico');
--1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population > (SELECT population FROM world
                      WHERE name='Russia');

--2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world 
 WHERE gdp/population> 
 (SELECT gdp/population FROM world WHERE name='United Kingdom') AND continent='Europe';

--3. List the name and continent of countries in the continents containing 
-- either Argentina or Australia. Order by name of the country.   
select name, continent from world where continent in (select continent from world
 where name ='Argentina' or name='Australia') order by name;

--4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.  
select name, population from world where population<(select population from world where name='Poland')
 and population>(select population from world where name='Canada') ;
 
--5.  Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. 
select name, concat(round(100*population/(select population from world 
 where name='Germany'),0),'%') from world where continent ='Europe';
                           

-- ALL function
--# Show each country that has a population > the population of ALL countries in Europe.
SELECT name FROM world
 WHERE population > ALL (SELECT population FROM world
                         WHERE continent='Europe');

--6. Which countries have a GDP greater than every country in Europe? 
--#[Give the name only.] (Some countries may have NULL gdp values)
select name from world where gdp> all(select gdp from world
                                      where continent='Europe' and gdp>0);
 
--7. !!! Find the largest country (by area) in each continent, show the continent, the name and the area:!!!
SELECT x.continent, x.name, x.area FROM world as x
  WHERE x.area = (SELECT max(y.area) FROM world as y
                  WHERE y.continent=x.continent AND population>0);

--8. !!! List each continent and the name of the country that comes first alphabetically.!!!
SELECT continent, name FROM world AS x 
 WHERE name<=ALL(SELECT name FROM world AS y WHERE x.continent=y.continent);


--9. Find the continents where all countries have a population <= 25000000. 
-- Then find the names of the countries associated with these continents. Show name, continent and population. 
SELECT name, continent, population FROM world AS x
 WHERE 25000000 >= ALL(SELECT population FROM world AS y WHERE y.population>0 AND x.continent=y.continent);

-- note can't be ALL(...)<= 25000000 syntax wrong

--10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world AS x
 WHERE x.population>=ALL(SELECT population*3 FROM world AS y
                         WHERE x.continent=y.continent AND population >0 AND x.name<>y.name);
   
