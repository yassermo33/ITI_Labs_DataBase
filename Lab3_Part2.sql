use Company_SD 
--Day 3
--DML
--2.1
insert Employee(SSN,Salary,Superssn,Dno)
values(102672,3000,112233,30)
--2.2
insert  Employee(Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn,Dno)
values ('yasser','mohammed',102660,25-10-1999,'Qena','M',NULL,NULL,30)


select * from Employee
--2.3
update Employee
set Salary+= salary*20/100
where SSN =102672
--DQL
--3.1
select *from Employee
--3.2
select Fname,Lname,Salary,Dno
from Employee
--3.3
select Pname,Plocation,Dnum
from Project
--3.4
select Fname +' '+Lname as fullname,Salary*10/100*12 as comission
--salary
--year salary*.10
--total *12 monthy

from Employee
--3.5
select  SSN , Fname +' '+Lname as fullname

from Employee
where Salary>5000
--3.6
select  Fname + ' ' +Lname as fullname,Salary
from Employee
where Sex ='f'
--3.7
select Dnum,Dname
from Departments
where MGRSSN = 968574 
--3.8
select Pnumber,Pname,Plocation
from Project
where Dnum = 10
--3.9
select Pnumber ,Pname,Plocation
from Project
where City ='Cairo ' or City='Alex'  
--3.10
select * from Project
where Pname like 'a%'
--3.11
select * from Employee
where Dno=30 and  Salary between 1000 and 2000

/*-- cross jpin     or   cartesian product 
select Dependent_name,Pnumber 
from Dependent ,Project
-- ineer join
select Dependent_name,Pnumber 
from Dependent ,Project
where Dependent.ESSN =Project.Dnum
*/



