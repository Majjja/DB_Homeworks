use [HOMEWORK]

--Homework requirement 1a/2
--Create new procedure called CreateGrade
--Procedure should create only Grade header info (not Grade Details) 
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)

create procedure dbo.CreateGrade(
					@StudentId int,
					@TeacherId int,
					@Grade tinyint,
					@CreatedDate datetime)
as
begin
	insert into dbo.Grade(StudentID, TeacherID, Grade, CreatedDate, CourseID)
	select @StudentId, @TeacherId, @Grade, @CreatedDate, g.CourseID
	from dbo.Grade as g
	where g.StudentID = @StudentId and g.TeacherID = @TeacherId

	select count(*) as TotalGrades
	from dbo.Grade
	where StudentID = @StudentId

	select max(Grade) as MaxGrade
	from dbo.Grade
	where StudentID = @StudentId and TeacherID = @TeacherId

end
go

execute dbo.CreateGrade 1, 2, 10, '2020.08.20'

--Homework requirement 1b/2
--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

create procedure dbo.CreateGradeDetail(
						@GradeId int,
						@AchievementTypeID tinyint,
						@AchievementPoints tinyint,
						@AchievementMaxPoints tinyint,
						@AchievementDate datetime)
as
begin
	insert into dbo.GradeDetails(GradeID, AchievementTypeID,AchievementPoints, AchievementMaxPoints, AchievementDate)
	select @GradeId, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate

	select g.Grade, sum(gd.AchievementPoints/gd.AchievementMaxPoints * [at].ParticipationRate) as SumOfGradePoints
	from dbo.GradeDetails as gd
	inner join dbo.AchievementType as [at] on [at].ID = gd.AchievementTypeID
	inner join dbo.Grade as g on g.ID = gd.GradeID
	where g.ID = @GradeId
	group by g.Grade
end
go

execute dbo.CreateGradeDetail 0, 1, 95, 100, '2020.08.20'
