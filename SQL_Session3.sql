use [HOMEWORK]

--Homework requirement 1
--Calculate the count of all grades in the system
select [Grade], count(*) as [Total Count]
from [dbo].[Grade]
group by [Grade]
order by [Grade]

--Calculate the count of all grades per Teacher in the system
select t.[FirstName] + N' ' + t.[LastName] as [Teacher Name], count(*) as [Total Grades]
from [dbo].[Teacher] as t
inner join [dbo].[Grade] as g
on t.ID = g.TeacherID
group by t.[FirstName] + N' ' + t.[LastName]

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
select t.[FirstName] + N' ' + t.[LastName] as [Teacher Name],  count(*) as [Total Grades]
from [dbo].[Grade] as g
inner join [dbo].[Teacher] as t
on g.TeacherID = t.ID
where g.StudentID < 100
group by t.[FirstName] + N' ' + t.[LastName]
order by [Teacher Name]

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select s.FirstName + ' ' + s.LastName as Student,max([Grade]) as [Maximal Grade], avg([Grade]) as [Average grade]
from [dbo].[Grade] as g
inner join [dbo].[Student] as s
on g.StudentID = s.ID
group by  s.FirstName + ' ' + s.LastName 

--Homework requirement 2
--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
select t.[FirstName] + ' ' + t.[LastName] as [Teacher], count(*) as [Total Grades]
from [dbo].[Teacher] as t
inner join [dbo].[Grade] as g
on t.ID = g.TeacherID
group by t.[FirstName] + ' ' + t.[LastName]
having count(*) > 200

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
select t.[FirstName] + ' ' + t.[LastName] as [Teacher], count(*) as [Total Grades]
from [dbo].[Teacher] as t
inner join [dbo].[Grade] as g
on t.ID = g.TeacherID
where g.[StudentID] < 100
group by t.[FirstName] + ' ' + t.[LastName]
having count(*) > 50

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
select s.ID, Count(*) as [Total Grades], max([Grade]) as [Maximal Grade], avg([Grade]) as [Average Grade]
from [dbo].[Student] as s
inner join [dbo].[Grade] as g
on s.ID = g.StudentID
group by s.ID
having max([Grade]) = avg([Grade])

--List Student First Name and Last Name next to the other details from previous query
select s.[FirstName] + ' ' + s.[LastName] as [Student], Count(*) as [Total Grades], max([Grade]) as [Maximal Grade], avg([Grade]) as [Average Grade]
from [dbo].[Student] as s
inner join [dbo].[Grade] as g
on s.ID = g.StudentID
group by s.[FirstName] + ' ' + s.[LastName]
having max([Grade]) = avg([Grade])

--Homework requirement 3
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
create view [dbo].[vv_StudentGrades]
as
select StudentID as [Student ID], count(*) as [Total Grades]
from [dbo].[Grade]
group by StudentID

--Change the view to show Student First and Last Names instead of StudentID
alter view [dbo].[vv_StudentGrades]
as
select s.FirstName + ' ' + s.LastName as [Student], count(*) as [Total Grades]
from [dbo].[Grade] as g
inner join [dbo].[Student] as s
on g.StudentID = s.ID
group by s.FirstName + ' ' + s.LastName

--List all rows from view ordered by biggest Grade Count
select *
from [dbo].[vv_StudentGrades]
order by [Total Grades] desc

--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
create view [vv_StudentGradeDetails]
as
select s.FirstName + ' ' + s.LastName as [Student],  count(*) as [Passed Courses]
from [dbo].[Student] as s
inner join [dbo].[Grade] as g
on s.ID = g.StudentID
inner join [dbo].[Course] as c
on c.ID = g.CourseID
group by s.FirstName + ' ' + s.LastName