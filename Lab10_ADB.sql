use World
/*1. Write a query to calculate the total population for each continent and country, using ROLLUP to 
include subtotals at the continent level. */
select c.Continent ,c.Name ,sum(convert(bigint,c.Population)) as subtotal
from Country c
group by  rollup(c.Continent ,c.Name)
--group by  rollup(c.Name,c.Continent ) --هيجيب ال sum بتاع كل دوله
/*2. Write a query showing the total population by continent and region, using CUBE to provide all 
possible subtotal combinations.*/
select c.Continent ,c.Region ,sum(convert(bigint,c.Population)) as subtotal
from Country c
group by cube(c.Continent ,c.Region)--group by 25 rows ,rollup for continent 7 rows 
                                    -- rollup for Region 25 rows
									-- sum_agg_total 1 row
/*select c.Continent ,c.Region ,sum(convert(bigint,c.Population)) as subtotal
from Country c                                   --rollup for each colums
group by grouping sets(c.Continent ,c.Region)*/  --groupingsets **disable of the behaver fro group by
                                                 --  no sum_agg_total 1 row 
----------------
/*3. Write a cursor to iterate through all countries and display their names along with their life 
expectancy, but only for countries where life expectancy is greater than 70.*/
declare cur cursor for select c.name,c.LifeExpectancyfrom Country cwhere c.LifeExpectancy >70for read only declare @name varchar(30),@life_exp intopen curfetch cur into @name,@life_exp while @@fetch_status =0 begin select @name,@life_exp fetch cur into @name,@life_exp end close cur deallocate cur
/*4. Use the MERGE statement to update a new table that stores the latest population figures for each 
country by merging data from the existing country table. */
create table new_country( code varchar(10) primary key ,population bigint)
insert into new_country 
values('ZY',11112222)
select * from new_country 

merge into new_country as _target
using country  as surce
on  _target.code=surce.code
when matched then
update
set _target.population=surce.population
when not matched then
insert 
values(surce.code,surce.population);
select* from new_country
-------------------
/*5. Create a cursor that loops through all countries with a GDP lower than a specified value and 
updates their GDP by increasing it by 5%. */
declare @old__gnp float =444.927286606278
declare c2 cursor
  for select c.Name, C.GNP
          from Country C
   for update 
   declare @names varchar(55) , @gnp float
    open c2
     fetch c2 into @names ,@gnp
     while @@fetch_status = 0
	   begin
	        if  @gnp<@old__gnp
	           update Country
	           set  GNP=@gnp *1.05
	           where current of c2
	          fetch c2 into @names ,@gnp
	         select @names ,@gnp
	 end
close c2
deallocate c2
---------------
/*6. Try to create different backup types. and then create scheduled job for it.*/
-- F/yasser.bak