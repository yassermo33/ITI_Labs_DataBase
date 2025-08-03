
--1
select count(St_Age) from Student
--2
select distinct(Ins_Name)from Instructor
--3
select s.St_Id, isnull(concat(s.St_Fname ,s.St_Lname), St_Lname) full_name,d.Dept_Name from Student s  join Department d
on d.Dept_Id = s.Dept_Id
--4
select i.Ins_Name , d.Dept_Name from Instructor i left join Department d on i.Dept_Id = d.Dept_Id
--5
select concat(s.St_Fname , s.St_Lname) full_name , c.Crs_Name , sc.Grade from Student s join Stud_Course sc 
on s.St_Id = sc.St_Id join Course c on sc.Crs_Id = c.Crs_Id
--6
select t.Top_Name , count(c.Top_Id) num_of_topic from Course c  join Topic t on c.Top_Id = t.Top_Id
group by t.Top_Name
--7
select min(i.Salary) minn,max(i.Salary) maxx from Instructor i
--8
select i.Salary, i.Ins_Name from Instructor i 
where i.Salary <(select avg(i.Salary) from Instructor i) 
--9
select d.Dept_Name , i.Salary from Department d join Instructor i on d.Dept_Id = i.Dept_Id
where i.Salary = (select min(Salary) from Instructor)

--10
select top(2) i.Salary from Instructor i order by i.Salary desc
-- 10 by rank
select *from (select DENSE_RANK () over (order by i.Salary desc) sa , 
Salary from Instructor i )Instructor where sa =1 or sa =2

--11
select i.Ins_Name , coalesce(convert(varchar(50),salary), 'bouns') from Instructor i
--12
select avg(isnull(i.Salary,0)) from Instructor i

--13
select (s1.St_Fname) super , (s2.St_Fname) name  from Student s1 join Student s2 on s2.St_super=s1.St_Id

--14

select *from(select DENSE_RANK () over (partition by Dept_id  order by i.Salary desc) sa , 
Salary , i.Dept_Id , i.Ins_Name from Instructor i )Instructor where sa <=2

 --15
 select *from( select Row_number() over(partition by Dept_id order by St_Age ) sa , s.St_Fname , s.Dept_Id from Student s) 
 Student 
 where sa  in (select top 1 Row_number() over(partition by Dept_id order by St_Age ) sa from Student order by NEWID())

--- anther solution 
 select *from( select Row_number() over(partition by Dept_id order by St_Age ) sa , s.St_Fname , s.Dept_Id from Student s) 
 Student 
 where sa  =1





