use World
/*1.1. Write a query that shows each continent's countries. Calculates a running total of population for 
each continent. Displays the country name, population, and cumulative population, order the 
results by continent and cumulative population. */
select c.Name,c.Population
,sum(convert (bigint, c.Population) )over(partition by continent order by population desc  ) as total
from Country c
--order by c.Continent , total 
/*1.2. Write a query that assigns a dense rank to countries within their respective continents based on 
population. Display the continent, country name, population, and population rank. Show only the 
top 5 countries in each continent by population. */
select *
from (
select top(5) c.Continent ,c.Name,c.Population, dense_rank() over (order by population desc )as DR
from Country c) as new
where DR=5
--or why?
/*select top(5) c.Continent ,c.Name,c.Population, rank() over (order by population desc )as DR
from Country c */
/*1.3. Write a query that lists countries for each continent. Shows the current country's population and 
displays the previous and next country's population within the same continent, order the results by 
continent and population. */
select continent, name,population ,
lag(Population ) over (partition by continent order by population desc) as previous_country_population ,
lead(population) over (partition by continent order by population desc)as next_country_population 
from Country c
order by continent,population desc
----------------------
/*1.4. Write a query that calculates the population quartile-=4group- for each country within its continent. Shows 
the continent, country name, population, and quartile, order the results by continent and quartile. */
select continent ,name,population ,
ntile(4) over (partition by continent order by population desc)as population_quartile
from Country c
order by Continent, population_quartile 
----------------
/*1.5. Write a query that compares each country's population with the previous and next country in its 
continent. Calculate the population difference. Display the continent, country name, population, 
previous country's population, and population difference, order the results by continent and 
population.*/
select continent,name,population,
lag(Population) over (partition by continent order by population desc) as previous_country_population ,
--lead(population) over (partition by continent order by population desc)as next_country_population ,
Population - lag(Population) over (partition by continent order by population ) as population_difference
from Country
order by continent,population 
-----------



















