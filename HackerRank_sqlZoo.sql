-- HackerRank sql 
-- Type of Triangle: Given 3 numbers, determine and output its shape
SELECT CASE WHEN A + B > C AND B + C > A AND A + C > B THEN
                CASE WHEN A = B AND B = C THEN 'Equilateral'
                     CASE WHEN A = B OR B = C OR A = C THEN 'Isosceles'
                         ELSE 'Scalene'
                END
            ELSE 'Not A Triangle'
        END
FROM TRIANGLES;

-- sqlzoo
--# SELECT-------------------------------------------------------------
  
SELECT name FROM world  WHERE name LIKE 'C%ia';
  
--# Find the countries that have three or more a in the name
SELECT name FROM world  WHERE name LIKE '%a%a%a%';
  
--#Find the countries that have "t" as the second character.
SELECT name FROM world WHERE name LIKE '_t%' ORDER BY name ;

SELECT name FROM world WHERE length(name)=4 ;
 
--# Find the country where the capital is the country plus "City".
SELECT name  FROM world
 WHERE capital = concat(name,' City');

--# Find the capital and the name where the capital includes the name of the country.
SELECT capital,name FROM world WHERE capital LIKE concat('%',name,'%');

--# Show the name and the extension where the capital is an extension of name of the country.
SELECT name, REPLACE(capital, name, '') AS extension FROM world 
 WHERE capital LIKE concat('%',name,'%') AND length(capital)>length(name);
 
--# Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. 
select name, population , area from world where area>3000000 xor population>250000000;

select name, round(gdp/population, -3) as percapitaGDP from world where gdp> 1000000000000;

SELECT name, capital from world 
 where LEFT(name,1)=LEFT(capital,1) AND NAME<>CAPITAL;
 

--# escape single quotes
select * from nobel where winner='Eugene O''Neill'

--# Show 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject  FROM nobel  WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),  subject, winner;
 
--# or:
SELECT winner, subject  FROM nobel  WHERE yr=1984
 ORDER BY CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END,  subject,winner;
 
--#show the year when neither a Physics or Chemistry award was given
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr FROM nobel  WHERE subject IN ('Chemistry','Physics'));
                 
                  

--# Nested select
--# List each country and its continent in the same continent as 'Brazil' or 'Mexico'.
SELECT name, continent FROM world
WHERE continent IN  (SELECT continent  FROM world WHERE name='Brazil'  OR name='Mexico');


--# Show each country that has a population > the population of ALL countries in Europe.
SELECT name FROM world
 WHERE population > ALL (SELECT population FROM world WHERE continent='Europe');
        
--# Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. 
select name, concat(round(100*population/(select population from world where name='Germany'),0),'%') 
from world where continent ='Europe'; 
 
--# Which countries have a GDP greater than every country in Europe? 
#[Give the name only.] (Some countries may have NULL gdp values)
select name from world where gdp>all(select gdp from world where continent='Europe' and gdp>0);
 
--# Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT x.continent, x.name, x.area FROM world as x
  WHERE x.area = (SELECT max(y.area) FROM world as y
                  WHERE y.continent=x.continent AND population>0);
