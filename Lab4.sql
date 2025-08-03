-----------*** Day 4 *****
--Day 4

--1.1. Display the department ID, name, ID, and name of its manager. 

select  D.Dnum ,D.Dname,E.Superssn,E.Fname + ' ' +E.Lname as name_of_manager
from  Employee E, Departments D 
where D.MGRSSN = E.SSN
--where D.Dnum = E.Dno


select  D.Dnum ,D.Dname,E.Superssn,E.Fname + ' ' +E.Lname as name_of_manager
from  Employee E right join Departments D 
on D.MGRSSN=E.SSN

use Company_SD

-------- or
select  D.Dnum ,D.Dname,E.Superssn,E.Fname + ' ' +E.Lname as name_of_manager
from  Employee E inner join  Departments D 
on E.SSN= D.MGRSSN
use Company_SD

 
--1.2 Retrieve the names of all employees in department 10 who work more than or equal to 10 hours 
--per week on the "AL Rabwah" project.

select e.Fname +'  ' +e.Lname as fullname 
fROM Employee e ,Works_for w,Project p
where e.SSN=w.ESSn and w.Pno=p.Pnumber
and e.Dno=10 and w.Hours>=10 and p.Pname='AL Rabwah'

--  --------or

select e.Fname +'  ' +e.Lname as fullname
from Employee e inner join Works_for w
on e.SSN=w.ESSn inner join Project p
on w.Pno=p.Pnumber and e.Dno=10 and w.Hours>=10 and p.Pname='AL Rabwah'

--1.3. Find the names of the employees who were directly supervised by Kamel Mohamed

select e.Fname +'  ' +e.Lname  as fullname
from Employee e , Employee s
where s.SSN=e.Superssn
and s.Fname ='Kamel' and s.Lname ='Mohamed'

----------- or

select e.Fname + ' ' + e.Lname as fullname
from Employee e inner join Employee s 
on s.SSN =e.Superssn 
and s.Fname='Kamel' and s.Lname = 'Mohamed'

--1.4 Retrieve the names of all employees and the names of the projects they are working on, sorted by 
--the project name.

select e.Fname + ' ' +e.Lname as name_of_employees  ,p.Pname as name_of_projects ,e.Dno
from Employee e , Works_for w , Project p
where e.SSN=w.ESSn and w.Pno=p.Pnumber
 order by p.Pname , e.Dno    -- áæ ÚÇíÒ ÇÚßÓ desc


 --1.5. For each project located in Cairo City, find the project number, the controlling department name, 
--the department manager's last name, the address, and the birthdate.

select p.Pnumber ,d.Dname,e.Lname,e.Address,e.Bdate
from Project p ,Departments d , Employee e
where p.Dnum=d.Dnum and d.MGRSSN=e.SSN and p.City='Cairo'

--------- or


select p.Pnumber ,d.Dname,e.Lname,e.Address,e.Bdate
from Project p inner join Departments d 
on p.Dnum=d.Dnum inner join Employee e
on  d.MGRSSN=e.SSN and   p.Dnum=d.Dnum and d.MGRSSN=e.SSN and p.City='Cairo'

--1.6. Display All Employees data and the data of their dependents, even if they have no dependents 

select e.*
from Employee e left join Dependent d
on e.SSN=d.ESSN

--ex 
select e.*  --e.Fname + ' ' +e.Lname ,d.Dname ,d.Dnum
from Employee e , Departments d
where e.SSN=d.MGRSSN
--**************
select  e.Fname + ' ' +e.Lname ,d.Dname ,d.Dnum
from Employee e left join Departments d
on e.SSN=d.MGRSSN
--**************************
select  e.Fname + ' ' +e.Lname ,d.Dname ,d.Dnum
from Employee e right join Departments d
on e.SSN=d.MGRSSN
--************************
select  e.Fname + ' ' +e.Lname ,d.Dname ,d.Dnum
from Departments d right join Employee e
on d.MGRSSN=e.SSN
--***************************

select e.*
from Employee e full outer join Dependent d
on e.SSN=d.ESSN
--aggregate function
select * from Employee
select sum(e.Salary)
from Employee e

select max(e.Salary),min(e.Salary),sum(e.Salary),sum(e.Salary)/count(e.Salary)
from Employee e


--2.1.  Calculate the total population for each continent
use World
select    sum(convert(bigint,c.Population)) as fullname ,c.Continent
from Country c
group by c.Continent

select  sum(cast ( c.Population as bigint)) as fullname ,c.Continent
from Country c , City ci
where  c.Code=ci.CountryCode
group by c.Continent

select * from Country


----------------
--2.2. Find the average life expectancy for each region. avg(c.LifeExpectancy) >65666565

select avg(c.LifeExpectancy) as average  ,c.Region
from Country c
--where avg(c.LifeExpectancy) >65666565
group by c.Region
--having
--or

select sum(c.LifeExpectancy)/count(c.LifeExpectancy) as average ,c.Region
from Country c
group by c.Region


--2.3 Determine the maximum and minimum surface area of countries on each continent.

select max(c.SurfaceArea) as maximum    ,min(c.SurfaceArea) as minimum ,c.Continent
from Country c
group by c.Continent

--2.4. Count the number of cities in each country. 

select count(ci.ID) as counters, co.Region
from City ci,Country co
where ci.CountryCode=co.Code
group by co.Region

----or
select count (ci.ID) as counter , c.Region
from city ci inner join Country c
on c.Code=ci.CountryCode
group by Region

--2.5. Calculate the total and average GNP of all countries.

select sum(c.GNP) as total  ,AVG(c.GNP) as average ,c.Region
from Country c 
group by c.Region
