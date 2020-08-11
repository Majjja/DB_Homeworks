use [HOMEWORK]

-- HOMEWORK REQUIREMENT 1
--Find all Students with FirstName = Antonio
select *
from [dbo].[Student]
where [FirstName] = 'Antonio'

--Find all Students with DateOfBirth greater than ‘01.01.1999’
select *
from [dbo].[Student]
where [DateOfBirth] > '1999.01.01'

--Find all Male students
select *
from [dbo].[Student]
where [Gender] = 'M'

--Find all Students with LastName starting With ‘T’
select *
from [dbo].[Student]
where [LastName] like 'T%'

--Find all Students Enrolled in January/1998
select *
from [dbo].[Student]
where [EnrolledDate] between '1998.01.01' and '1998.01.31'

--Find all Students with LastName starting With ‘J’ enrolled in January/1998
select *
from [dbo].[Student]
where [LastName] like 'J%' and [EnrolledDate] between '1998.01.01' and '1998.01.31'

-- HOMEWORK REQUIREMENT 2
--Find all Students with FirstName = Antonio ordered by Last Name
select *
from [dbo].[Student]
where [FirstName] = 'Antonio'
order by [LastName] asc

--List all Students ordered by FirstName
select *
from [dbo].[Student]
order by [FirstName] asc

--Find all Male students ordered by EnrolledDate, starting from the last enrolled
select *
from [dbo].[Student]
where [Gender] = 'M'
order by [EnrolledDate] desc

-- HOMEWORK REQUIREMENT 3
--List all Teacher First Names and Student First Names in single result set with duplicates
select [FirstName]
from [dbo].[Teacher]
union all
select [FirstName]
from [dbo].[Student]

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
select [LastName]
from [dbo].[Teacher]
union
select [LastName]
from [dbo].[Student]

--List all common First Names for Teachers and Students
select [FirstName]
from [dbo].[Teacher]
intersect
select [FirstName]
from [dbo].[Student]

-- HOMEWORK REQUIREMENT 4
--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
alter table [dbo].[GradeDetails]
add constraint [DF_GradeDetails_AchievementMaxPoints]
default (100) for [AchievementMaxPoints]

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
alter table [dbo].[GradeDetails] with check
add constraint [CHK_GradeDetails_AchievementPoints]
check([AchievementPoints] <= [AchievementMaxPoints])

--Change AchievementType table to guarantee unique names across the Achievement types
alter table [dbo].[AchievementType] with check
add constraint [UQ_AchievementType_Name]
unique ([Name])

-- HOMEWORK REQUIREMENT 5
--Create Foreign key constraints from diagram or with script
alter table [dbo].[Grade] with check
add constraint [FK_Grade_TeacherID]
foreign key ([TeacherID])
references [dbo].[Teacher] ([ID])

alter table [dbo].[Grade] with check
add constraint [FK_Grade_StudentID]
foreign key ([StudentID])
references [dbo].[Student] ([ID])

alter table [dbo].[Grade] with check
add constraint [FK_Grade_CourseID]
foreign key ([CourseID])
references [dbo].[Course] ([ID])
