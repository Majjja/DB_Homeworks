use [HOMEWORK]

-- HOMEWORK REQUIREMENT 1
-- 1. Declare scalar variable for storing FirstName values
--		Assign value ‘Antonio’ to the FirstName variable
--		Find all Students having FirstName same as the variable
declare @FirstName nvarchar(50)
set @FirstName = 'Antonio'

select *
from [dbo].[Student]
where [FirstName] = @FirstName

-- 2. Declare table variable that will contain StudentId, StudentName and DateOfBirth
--		Fill the table variable with all Female students
declare @StudentInfo table (StudentId int, StudentName nvarchar(50), DateOfBirth date)

insert into @StudentInfo(StudentId, StudentName, DateOfBirth)
select [ID], [FirstName], [DateOfBirth]
from [dbo].[Student]
where [Gender] = 'F'

select *
from @StudentInfo

-- 3. Declare temp table that will contain LastName and EnrolledDate columns
--		Fill the temp table with all Male students having First Name starting with ‘A’
--		Retrieve the students from the table which last name is with 7 characters
create table #StudentInfo2 (LastName nvarchar(60), EnrolledDate date)

insert into #StudentInfo2(LastName, EnrolledDate)
select LastName, EnrolledDate
from [dbo].[Student]
where [Gender] = 'M' and [FirstName] like 'A%'

select *
from #StudentInfo2
where len([LastName]) = 7

-- 4. Find all teachers whose FirstName length is less than 5 and
--		the first 3 characters of their FirstName and LastName are the same
select *
from [dbo].[Teacher]
where len([FirstName]) < 5 and left([FirstName], 3) = left([LastName], 3)

-- HOMEWORK REQUIREMENT 2
-- 1. Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:
--		StudentCardNumber without “sc-”
--		“ – “
--		First character of student FirstName
--		“.”
--		Student LastName
create function [dbo].[fn_FormatStudentName] (@StudentID int)
returns nvarchar(200)
as
begin
	declare @result nvarchar(200)
	select @result = substring([StudentCardNumber], 4, 50) + '-' + left([FirstName], 1) + '.' + [LastName]
	from [dbo].[Student]
	where ID = @StudentID
	return @result
end

select *, [dbo].[fn_FormatStudentName] (ID) as FunctionOutput
from [dbo].[Student]