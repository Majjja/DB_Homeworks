create database HOMEWORK
GO

use HOMEWORK
GO

drop table if exists [dbo].[Student];
drop table if exists [dbo].[Teacher];
drop table if exists [dbo].[GradeDetails];
drop table if exists [dbo].[Course];
drop table if exists [dbo].[Grade];
drop table if exists [dbo].[AchievementType];


create table [dbo].[Student]
(
	 [ID] [int] identity(1, 1) not null,
	 [FirstName] [nvarchar](50) not null,
	 [LastName] [nvarchar](50) not null,
	 [DateOfBirth] [date] not null,
	 [EnrolledDate] [datetime] not null,
	 [Gender] [nchar](1) not null,
	 [NationalIDNumber] [nvarchar](50) not null,
	 [StudentCardNumber] [nvarchar](50) not null,
	 constraint [PK_Student] primary key clustered ([ID] asc)
)
GO

create table [dbo].[Teacher]
(
	[ID] [int] identity(1, 1) not null,
	[FirstName] [nvarchar](50) not null,
	[LastName] [nvarchar](50) not null,
	[DateOfBirth] [date] not null,
	[AcademicRank] [nvarchar](50) not null,
	[HireDate] [date] not null,
	constraint [PK_Teacher] primary key clustered ([ID] asc)
)
GO

create table [dbo].[GradeDetails]
(
	[ID] [int] identity(1, 1) not null,
	[GradeID] [int] not null,
	[AchievementTypeID] [tinyint] not null,
	[AchievementPoints] [tinyint] not null,
	[AchievementMaxPoints] [tinyint] not null,
	[AchievementDate] [datetime] not null,
	constraint [PK_GradeDetails] primary key clustered ([ID] asc)
)
GO

create table [dbo].[Course]
(
	[ID] [smallint] identity(1, 1) not null,
	[Name] [nvarchar](50) not null,
	[Credit] [tinyint] not null,
	[AcademicYear] [tinyint] not null,
	[Semester] [tinyint] not null,
	constraint [PK_Course] primary key clustered ([ID] asc)
)
GO

create table [dbo].[Grade]
(
	[ID] [int] identity(1, 1) not null,
	[StudentID] [int] not null,
	[CourseID] [smallint] not null,
	[TeacherID] [int] not null,
	[Grade] [tinyint] not null,
	[Comment] [nvarchar](100) null,
	[CreatedDate] [datetime] not null,
	constraint [PK_Grade] primary key clustered ([ID] asc)
)
GO

create table [dbo].[AchievementType]
(
	[ID] [tinyint] identity(1, 1) not null,
	[Name] [nvarchar](50) not null,
	[Description] [nvarchar](100) null,
	[ParticipationRate] [tinyint] not null,
	constraint [PK_AchievementType] primary key clustered ([ID] asc)
)
GO