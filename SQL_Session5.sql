use [HOMEWORK]
go

--Create multi-statement table value function that for specific Teacher and Course will return list of students (FirstName, LastName) 
-- who passed the exam, together with Grade and CreatedDate

create function [dbo].[fn_ListOfStudents] (@TeacherId int, @SCourseId smallint)
returns @result table(FirstName nvarchar(50), LastName nvarchar(50), Grade tinyint, CreatedDate datetime)
as
begin

	insert into @result(FirstName, LastName, Grade, CreatedDate)
	select s.FirstName as StudentFirstName, s.LastName as StudentLastName, g.Grade, g.CreatedDate 
	from dbo.Grade as g
	inner join dbo.Student as s
	on s.ID = g.StudentID
	where g.TeacherID = @TeacherId and g.CourseID = @SCourseId

return
end
go

select *
from dbo.fn_ListOfStudents(1, 1)
go
