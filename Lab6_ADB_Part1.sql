use Company_SD
-- 1.1. Create Scalar function named GetEmployeeSupervisor Type: Scalar Description: Returns the 
--name of an employee's supervisor based on their SSN. 

create function GetEmployeeSupervisor( @ssn int )
returns varchar(30)
 begin 
 declare @emp_name varchar(30)
  select @emp_name= e.Fname   +' ' +  e.Lname   
  from Employee e
  where e.SSN=@ssn
  return @emp_name
 end
 select [dbo].[GetEmployeeSupervisor](223344)

 --1.2. Create an inline table-Valued Function GetHighSalaryEmployees  
--Description: Returns a table of employees with salaries higher than a specified amount. 
create function GetHighSalaryEmployees(@ssn int )
returns table 
as
 return
 (
 select e.*
 from Employee e
 where  e.Salary>@ssn
 )
select * from GetHighSalaryEmployees(2000)
--select sum(Salary) from GetHighSalaryEmployees(225)

--1.3. Multi-Statement Table-Valued Function: GetProjectAverageHours Type: Multi-Statement 
--Description: Returns the average hours worked by employees on a specific project as a table.

Create or alter Function GetProjectAverageHours (@projID int )
returns @table Table (ProjName varchar(20) ,Avghours int)
as
begin
     Insert into @table
	 select p.Pname , Avg(Hours) 
	 from Project p , Works_for wf
	 where p.Pnumber = wf.Pno and @projID = wf.Pno
	 Group by p.Pname
	 return 
	end
	select * from dbo.GetProjectAverageHours()

--1.4Create function with name GetTotalSalary Type: Scalar Function Description: Calculates and 
--returns the total salary of all employees in the specified department
create function GetTotalSalary(@dep int)
returns float 
begin 
declare @tosalary float
select @tosalary=sum(e.Salary)
from Employee e
where e.Dno=@dep
return @tosalary
end
select dbo.GetTotalSalary(30)
--1.5. Create a function with GetDepartmentManager Type: Inline Table-Valued Function Description: 
--Returns the manager's name and details for a specific department. 
create function GetDepartmentManager(@dep int)
returns table
as 
return 
(
select e.Fname + ' ' + e.Lname as manager ,d.*
from Employee e , Departments d
where e.SSN=d.MGRSSN and @dep=d.Dnum
)
select * from dbo.GetDepartmentManager(20)

-----rules
--3.1. Make a rule that makes sure the value is less than 1000, 
--then bind it on the salary in the employee table.

alter table Employee
add constraint  salary  check(salary>100)  






/*CREATE FUNCTION GetTotalSalary (@DepartmentID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalSalary DECIMAL(18,2)

    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID

    RETURN ISNULL(@TotalSalary, 0)
END;*/


















drop function GetHighSalaryEmployees
 /*2. Create an inline table-Valued Function GetHighSalaryEmployees  
Description: Returns a table of employees with salaries higher than a specified amount. */

create Function GetHighSalaryEmployees ()
returns table 


 /*create function myfunction(@var int, @var1 varchar(10))

create function GetStudentName(@id int)
returns varchar(20)
  begin 
     declare @StdName varchar(20)

	 select @StdName = St_Fname
	 from Student 
	 where St_Id = @id

	 return @StdName
  end 
*/