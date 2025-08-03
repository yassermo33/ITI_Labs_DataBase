use Company_SD
--1.1. Create a view that shows the project number and name along with the total number of hours
--worked on each project and the name of the department managing the project
create or alter view shows
as
select p.Pnumber ,p.Pname , sum(w.Hours) as hour,d.Dnum 
from Works_for w , Project p,Departments d
where w.Pno=p.Pnumber and p.Dnum=d.Dnum
group by  p.Pnumber,p.Pname ,d.Dnum
select*from shows
--1.2. Create a view that displays the name and salary of employees who earn more than their managers
create or alter view v2
as
select e.Fname + ' ' +e.Lname as fullname ,e.Salary
from Employee e , Employee s
where s.Superssn=e.SSN and e.Salary>s.Salary
select * from v2

--1.3. Create a view that displays the department number, name, and the number of employees in each
--department.
create or alter  view v3
as
select d.Dnum,d.Dname ,count(e.SSN) as count
from Employee e , Departments d
where e.SSN=d.MGRSSN
group by d.Dnum ,d.Dname
select * from v3
--1.4. Create a view that displays the names of employees who have dependents, along with the number
--of dependents each employee has.
create or alter  view v4
as
select  e.Fname +' ' + e.Lname as fullname ,count (d.ESSN) as number_of_dep
from Employee e  left join   Dependent d
on e.SSN= d.ESSN
where d.Dependent_name is not null
group by e.Fname,e.Lname
select * from v4
--1.5. Create a view that displays the full name (first name and last name), salary, and the name of the
--department for employees working in the department with the highest average salary.
--create or alter view v5
--as
--- 1 step
select    e.Fname + ' ' + e.Lname as full_name , d.Dnum ,e.Salary,d.Dname
			from Employee e inner join Departments d
			on e.Dno=d.Dnum
--- 2 step
select   d.Dnum ,avg(e.Salary) as average ,d.Dname
			from Employee e inner join Departments d
			on e.Dno=d.Dnum
			group by d.Dnum ,d.Dname

---3step

create or alter view v5
as
select e.Fname + ' ' + e.Lname as full_name ,e.Salary , d.Dname 
from Employee e join Departments d on e.Dno=d.Dnum 
where d.Dnum =(select top 1     d.Dnum
			from Employee e inner join Departments d
			on e.Dno=d.Dnum
			group by d.Dnum
			order by avg(e.Salary) DESC
			
            )
select * from v5
--anthor answer
select top 1    d.Dnum ,(avg(e.Salary))as top_salary ,d.Dname ,e.Fname + ' ' + e.Lname as full_name
			from Employee e inner join Departments d
			on e.Dno=d.Dnum
			group by d.Dnum ,d.Dname ,e.Fname + ' ' + e.Lname 
			order by avg(e.Salary) DESC

--1.6. Create a view that lists the names and ages of employees and their dependents 
--(if any) in a single 
--result set. The age should be calculated based on the current date.
create or alter view v6
as
 select concat(e.Fname,e.Lname) as full_name,datediff(year ,e.Bdate,('2025-03-26') )as age							
 from Employee e 
 union 
 select d.Dependent_name, datediff(year ,d.Bdate,('2025-03-26') ) as age
 from Dependent d
 select * from v6
 --index
 --2.1. Create an index on the column (Hiredate) that allows you to cluster 
 --the data in the table Department.What will happen?
 
 use ITI_new
 create  clustered index indx
 on Department(manager_hiredate)
 --2.2. Create an index that allows you to enter unique ages in the student table.
 --What will happen?
 create  unique index indx
 on student(St_Age)
 
 --2.3. Create a non-clustered index in the column (Dept_Manager) that allows you
--to enter a unique instructor ID in the table Department.
create nonclustered index indx
on Department(Dept_Manager)


 



			
            



 












			select  E.Fname + ' ' + E.Lname as Ename , E.Salary , D.Dname , E.SSN 

from Employee E join Departments D on E.Dno = D.Dnum
/*group by E.Fname + ' ' + E.Lname  , E.Salary , D.Dname
order by  avgSalary*/
where D.Dnum = ( select top 1 D.Dnum  
		from Employee E join Departments D on E.Dno = D.Dnum
		group by D.Dnum
		order by avg ( E.Salary ) DESC )












