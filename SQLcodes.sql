-- HackerRank sql
--# Given 3 numbers, determine and output its shape


SELECT CASE             
            WHEN A + B > C AND B + C > A AND A + C > B THEN
                CASE 
                    WHEN A = B AND B = C THEN 'Equilateral'
                    WHEN A = B OR B = C OR A = C THEN 'Isosceles'
                    ELSE 'Scalene'
                END
            ELSE 'Not A Triangle'
        END
FROM TRIANGLES;

-- sqlzoo

--# SELECT-----------SELECT-----------SELECT-----------SELECT-----------

SELECT * FROM CITY WHERE COUNTRYCODE='USA' AND POPULATION>100000

SELECT NAME FROM CITY WHERE COUNTRYCODE='USA' AND POPULATION>120000


SELECT name, population FROM world
  WHERE name IN ('Sweden', 'norway', 'Denmark');
  
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
  
SELECT name FROM world
  WHERE name LIKE 'Y%'
  
SELECT name FROM world
  WHERE name LIKE '%y'
  
SELECT name FROM world
  WHERE name LIKE '%x%'
  
SELECT name FROM world
  WHERE name LIKE 'C%ia'
  
--# Find the countries that have three or more a in the nam
SELECT name FROM world
  WHERE name LIKE '%a%a%a%'
  
--#Find the countries that have "t" as the second character.
SELECT name FROM world WHERE name LIKE '_t%'
ORDER BY name  

SELECT name FROM world
 WHERE length(name)=4 
 
SELECT name  FROM world  WHERE name = capital

--# Find the country where the capital is the country plus "City".
SELECT name  FROM world
 WHERE capital = concat(name,' City') 
or:  WHERE capital = concat(name,' ', 'City') 

--# Find the capital and the name where the capital includes the name of the country.
SELECT capital,name FROM world WHERE capital LIKE concat('%',name,'%')

--# Show the name and the extension where the capital is an extension of name of the country.
SELECT name, REPLACE(capital, name, '') AS extension FROM world 
 WHERE capital LIKE concat('%',name,'%') AND length(capital)>length(name)
 
SELECT name, gdp/population AS percapitalGDP FROM world 
 WHERE population>200000000
 
--# Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. 
select name, population , area from world where area>3000000 xor population>250000000

select name, round(population/1000000,2), round(gdp/1000000000,2) from world where continent='South America'

select name, round(gdp/population, -3) as percapitaGDP from world where gdp> 1000000000000

SELECT name, capital from world 
 where LEFT(name,1)=LEFT(capital,1) AND NAME<>CAPITAL
 
--# 8. Show the Physics winners for 1980 together with the Chemistry winners for 1984.
select yr, subject, winner from nobel where (subject='Physics' and yr=1980) 
  or (subject='Chemistry ' and yr=1984)


select winner, yr, subject from nobel where winner like 'Sir%' order by yr desc, winner

--# escape single quotes
select * from nobel where winner='Eugene O''Neill'

--# Show 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject  FROM nobel  WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),  subject,winner
 
--# or:
SELECT winner, subject  FROM nobel  WHERE yr=1984
 ORDER BY CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END,  subject,winner
 
--#show the year when neither a Physics or Chemistry award was given
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr 
                   FROM nobel
                 WHERE subject IN ('Chemistry','Physics'))
                 

--# shows years when a Medicine award was given but no Peace or Literature award was
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')
                   
--# shows the amount of years where no Medicine awards were given
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')
 
--# Nested select
--# List each country and its continent in the same continent as 'Brazil' or 'Mexico'.
SELECT name, continent FROM world
WHERE continent IN
  (SELECT continent 
     FROM world WHERE name='Brazil'
                   OR name='Mexico')
                   
--# Show the population of China as a multiple of the population of the United Kingdom
SELECT
 population/(SELECT population FROM world
             WHERE name='United Kingdom')
  FROM world
WHERE name = 'China'

--# Show each country that has a population > the population of ALL countries in Europe.
SELECT name FROM world
 WHERE population > ALL
      (SELECT population FROM world
        WHERE continent='Europe')
        
select name, continent from world where continent in (select continent from world
 where name ='Argentina' or name='Australia') order by name

select name, population from world where population<(select population from world where name='Poland')
 and population>(select population from world where name='Canada') 
 
--# Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany. 
select name, concat(round(100*population/(select population from world 
 where name='Germany'),0),'%') from world where continent ='Europe'
 
--# Which countries have a GDP greater than every country in Europe? 
#[Give the name only.] (Some countries may have NULL gdp values)
select name from world where gdp>all(select gdp from world
 where continent='Europe' and gdp>0)
 
--# Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT x.continent, x.name, x.area FROM world as x
  WHERE x.area = (SELECT max(y.area) FROM world as y
        WHERE y.continent=x.continent
          AND population>0)


