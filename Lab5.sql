 use ITI_new
 
-- lab 5
--5.1. Simple Subquery: Write a query to find all courses with a duration 
--longer than the average course duration.

 select c.Crs_Name
 from Course c
 where  c.Crs_Duration >(select  avg(c.Crs_Duration)
                           from Course c) 

	--5.2 Correlated Subquery: Find the names of students who are older than 
   --the average age of students in their department.  
         
select s.St_Fname + ' ' + s.St_Lname as full_name
from Student s
where s.St_Age>(select avg(s2.St_Age)
                from Student s2
				where s.Dept_Id=s2.Dept_Id
				group by s2.Dept_Id)

--5.3Subquery in SELECT Clause: For each student, display their name 
--and the number of courses they are enrolled in.
select  s.St_Fname + ' ' + s.St_Lname as full_name 
		,(select count(sc.Crs_Id) from Stud_Course sc
			where sc.St_Id=s.St_Id )
from Student s
--5.4. Find the name and salary of the instructor who earns more than the 
--average salary of their department.
select i1.Ins_Name
from Instructor i1
where i1.Salary >(select  avg(i2.Salary)
                  from Instructor i2
				  where i1.Dept_Id=i2.Dept_Id
				  group by i2.Dept_Id)
--5.5  Subquery with IN: Find all students who are enrolled in 'C 
--Programming' or 'Java'.

select  s.*
 from Student s , Stud_Course st
 where s.St_Id = st.St_Id  and st.Crs_Id in( select  c.Crs_Id
  from course c  where c.Crs_Id = st.Crs_Id  and c.Crs_Name ='C Progamming' or c.Crs_Name = 'Java' )
  ---or
select  s.St_Id
 from Student s  
 where s.St_Id in ( select st.St_Id from Stud_Course st 
					where  s.St_Id = st.St_Id  
							and st.Crs_Id in( select  c.Crs_Id
												from course c 
												where c.Crs_Id = st.Crs_Id 
												and (c.Crs_Name ='C Progamming' or c.Crs_Name = 'Java' )))

  --------------------------or

  select  s.St_Id
 from Student s  
		 where s.St_Id in ( select st.St_Id from Stud_Course st 
							 where  st.Crs_Id in( select  c.Crs_Id
													from course c    
													where (c.Crs_Name ='C Progamming' or c.Crs_Name = 'Java' )))

/*select avg(s.St_Age)
from Student s
group by s.Dept_Id */

--2.1 Combine the names of all students and instructors into a single list. 
-----  -- UNION
select st_id, s.St_Fname +' ' + s.St_Lname as full_name
from Student s
union -- all
select i.Ins_Name , Ins_Degree
from Instructor i

------2.2. Create a list of courses that either have a duration longer than 50 
------hours or are taught by an instructor named 'Ahmed'.
select  c.Crs_Name
from Instructor i ,Ins_Course ic , Course c
where i.Ins_Id=ic.Ins_Id and ic.Crs_Id=c.Crs_Id and i.Ins_Name='Ahmed'
intersect 
select c.Crs_Name
from Course c
where c.Crs_Duration>50
				  



				

		




				

