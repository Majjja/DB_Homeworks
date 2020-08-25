--use [HOMEWORK]

/*Add error handling on CreateGradeDetail procedure
Test the error handling by inserting not-existing values for AchievementTypeID*/

alter procedure dbo.CreateGradeDetail(
						@GradeId int,
						@AchievementTypeID tinyint,
						@AchievementPoints tinyint,
						@AchievementMaxPoints tinyint,
						@AchievementDate datetime)
as
begin
	begin try
		insert into dbo.GradeDetails(GradeID, AchievementTypeID,AchievementPoints, AchievementMaxPoints, AchievementDate)
		select @GradeId, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate

		select sum(gd.AchievementPoints/gd.AchievementMaxPoints * [at].ParticipationRate) as SumOfGradePoints
		from dbo.GradeDetails as gd
		inner join dbo.AchievementType as [at] on [at].ID = gd.AchievementTypeID
	end try
	begin catch
		select
			ERROR_NUMBER() as ErrorNumber,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage
		return
	end catch
end
go

--execute dbo.CreateGradeDetail 0, 1, 95, 100, '2020.08.20'
execute dbo.CreateGradeDetail 0, null, 95, 100, '2020.08.20'