use ITI_new
--1.1. Create a stored procedure to show the number of students per department.
create or alter proc show_number
as
begin
 select s.Dept_Id, COUNT(*) AS student_count
    from student s 
    group by  s.Dept_Id;
	end
show_number
--1.2. Create a trigger to prevent anyone from inserting a new record in the department.
create or alter trigger prevent
on department
instead of  insert 
as
select ' can’t insert a new record in that table'
insert into Department (Dept_Id , Dept_Name) values (123 , 'test')
--disable trigger prevent on department
--1.3. Create a trigger on student table 
--after insert to add Row in Student Audit table 
create table Audit_table1
(server_user_name varchar(50),
 _date date,
  note varchar(100))
  --drop table Audit_table1
create or alter trigger after_insert_to_add_Row_in_Student_Audit_table 
on student
after insert
as
begin--system_user as Server_User_Name ,getdate() as _date,
declare @note varchar(100)
select  @note=concat(system_user ,' inserted new row with key=',s.St_Id,'in table student ')
from student s 
insert into Audit_table1
values(system_user ,getdate(),@note)
end
--where s.St_Id=3
 insert into Student(St_Id,St_Fname,St_Age)
 values(124,'yasser',25)
 select * from Audit_table1
----------------
/*2.1. Create a stored procedure that will check for the number of employees in the project 
100 If they are more than 3, print a message to the user, 'The number of employees 
in the project 100 is 3 or more.' If they are less, display a message to the user, 'The 
following employees work for project 100, in addition to the first name and last 
name of each one. */
use Company_SD
create or alter proc checks
as
begin
 declare @counts int
 select @counts=count(wf.ESSn)
 from Works_for wf
 where wf.Pno=100
      
 if(@counts>=3)
	   begin
	   select 'The number of employees in the project 100 is 3 or more.'
       end
 else
	   begin
       select concat ('The following employees work for project 100',e.Fname ),e.Salary
	   from Works_for wf,Employee e
       where wf.ESSn=e.SSN and wf.Pno=100
       end
end

checks
----------------
--2.2. Create a stored procedure that will be used in case an old employee has left the 
--project and a new one becomes instead of him. The procedure should take 3 
--parameters (old employee number, new employee number, and the project number), 
--and it will be used to update the works_for table.
create or alter proc old_employee_has_left
(@old_emp_number int,@new_emp_number int ,@pro_number int )
as
begin
update Works_for
set  ESSn=@new_emp_number
where ESSn=@old_emp_number and Pno=@pro_number
end
 
 execute old_employee_has_left  112233 ,202,1001


--2.3. Create a trigger that prevents the insertion process for the employee table in 
--February and test it.  
create or alter trigger prevents_the_insertion
on Employee
after insert 
as
if month(getdate())= 4--'February'   --if MONTH(GETDATE()) = 'February'
select 'not allowed  insertion employee in february'
insert into Employee(SSN ,Fname )
values(654546565,'jujkd,ds')
-----------
--2.4. Create a trigger that prevents users from altering any table. 
create or alter trigger no_altering_any_table
on database
instead of delete , update,insert
as
select 'no altering any table'
-------------
use Company_SD
--2.5.Create an Audit table with the following structure
create table aduit_table2
(project_number int,
 username varchar(100),
  ModifiedDate date,
  Hours_Old int,
  Hours_new int)
create or alter trigger If_a_user_updated_the_Hours_column
on works_for 
after update
as
begin
if update(hours)
declare @project_number int
declare @Hours_Old int
declare @Hours_new int 
select @project_number=Pno from Works_for   select @project_number=(select Pno from inserted) 
/*select @Hours_Old  hours from deleted */   select @Hours_Old=(select hours from deleted)
/*select @Hours_new hours from inserted */    select @Hours_new =(select hours from inserted)
insert into aduit_table2
values(@project_number,system_user,getdate(),@Hours_Old,@Hours_new)
end 
update Works_for
set Hours =10
where Pno=100 and ESSn=112233
select* from aduit_table2





