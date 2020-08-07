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
	 [Id] [int] identity(1, 1) not null,
	 [FirstName] [nvarchar](100) not null,
	 [LastName] [nvarchar](100) not null,
	 [DateOfBirth] [date] null,
	 [EnrolledDate] [datetime] null,
	 [Gender] [nchar] null,
	 [NationalIDNumber] [nvarchar](50) null,
	 [StudentCardNumber] [nvarchar](50),
	 constraint [PK_Student] primary key clustered ([Id] asc)
)
GO

create table [dbo].[Teacher]
(
	[Id] [smallint] identity(1, 1) not null,
	[FirstName] [nvarchar](100) not null,
	[LastName] [nvarchar](100) not null,
	[DateOfBirth] [date] null,
	[AcademicRank] [nvarchar](50) null,
	[HireDate] [date] null,
	constraint [PK_Teacher] primary key clustered ([Id] asc)
)
GO

create table [dbo].[GradeDetails]
(
	[Id] [int] identity(1, 1) not null,
	[GradeID] [int] null,
	[AchievementTypeID] [int] null,
	[AchievementPoints] [smallint] null,
	[AchievementMaxPoints] [smallint] null,
	[AchievementDate] [date] null,
	constraint [PK_GradeDetails] primary key clustered ([Id] asc)
)
GO

create table [dbo].[Course]
(
	[Id] [smallint] identity(1, 1) not null,
	[Name] [nvarchar](100) not null,
	[Credit] [int] null,
	[AcademicYear] [nvarchar](10) null,
	[Semester] [tinyint] null,
	constraint [PK_Course] primary key clustered ([Id] asc)
)
GO

create table [dbo].[Grade]
(
	[Id] [int] identity(1, 1) not null,
	[StudentId] [int] null,
	[CourseId] [smallint] null,
	[TeacherId] [smallint] null,
	[Grade] [tinyint] null,
	[Comment] [nvarchar](100) not null,
	[CreatedDate] [datetime] null,
	constraint [PK_Grade] primary key clustered ([Id] asc)
)
GO

create table [dbo].[AchievementType]
(
	[Id] [int] identity(1, 1) not null,
	[Name] [nvarchar](50) not null,
	[Description] [nvarchar](100) null,
	[ParticipationRate] [decimal](15, 2),
	constraint [PK_AchievementType] primary key clustered ([Id] asc)
)
GO