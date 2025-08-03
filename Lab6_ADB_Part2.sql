use ITI_new
--2.1. Table-Valued Function: Get Instructors with Null Evaluation: This function returns a table 
--containing the details of instructors who have null evaluations for any course.
create or alter function GetInstructors_with_Null_Evaluation()
returns table 
as
return
(
select i.* 
from Instructor i inner join  Ins_Course ic 
on  i.Ins_Id=ic.Ins_Id 
where  ic.Evaluation  is null 
)
select* from dbo.GetInstructors_with_Null_Evaluation()

--2.2. Table-Valued Function: Get Top Students: This function returns a table containing the top students
--based on their average grades.create or alter function Get_Top_Students()returns table asreturn(select top 5 s.St_Id,s.St_Fname , (avg(sc.Grade)) as gradefrom Student s inner join Stud_Course scon s.St_Id=sc.St_Idgroup by s.St_Id ,s.St_Fname order by  avg(sc.Grade) desc)select *from dbo.Get_Top_Students()--2.3. Table-Valued Function: Get Students Without Courses: This function returns a table containing 
--details of students who are not registered for any course. create or alter function Get_Students_Without_Courses()returns table as return(select s.* ,sc.Crs_Idfrom Student s left join Stud_Course scon s.St_Id=sc.St_Idwhere sc.Crs_Id is   null)select * from dbo.Get_Students_Without_Courses()


