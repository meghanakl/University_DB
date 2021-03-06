﻿/*
Deployment script for University_DB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "University_DB"
:setvar DefaultFilePrefix "University_DB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Tbl_Barrower].[Barrower_Type] on table [dbo].[Tbl_Barrower] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Tbl_Barrower])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping [dbo].[FK_Tbl_Barrower_Tbl_Barrowed_Book]...';


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] DROP CONSTRAINT [FK_Tbl_Barrower_Tbl_Barrowed_Book];


GO
PRINT N'Dropping [dbo].[FK_Tbl_Book_Tbl_Barrowed_Book]...';


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] DROP CONSTRAINT [FK_Tbl_Book_Tbl_Barrowed_Book];


GO
PRINT N'Starting rebuilding table [dbo].[Tbl_Barrower]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Tbl_Barrower] (
    [Id]                        INT          IDENTITY (1, 1) NOT NULL,
    [Title]                     VARCHAR (3)  NOT NULL,
    [First_Name]                VARCHAR (30) NOT NULL,
    [Last_Name]                 VARCHAR (30) NOT NULL,
    [AddressLine1]              VARCHAR (30) NOT NULL,
    [AddressLine2]              VARCHAR (30) NULL,
    [City]                      VARCHAR (30) NOT NULL,
    [StateName]                 VARCHAR (30) NOT NULL,
    [Country]                   VARCHAR (30) NOT NULL,
    [PostCode]                  VARCHAR (10) NOT NULL,
    [Mobile_Number_CountryCode] VARCHAR (5)  NOT NULL,
    [Mobile_Number]             VARCHAR (10) NOT NULL,
    [Email_Id]                  VARCHAR (20) NOT NULL,
    [Barrower_Type]             VARCHAR (20) NOT NULL,
    [LastUpdated]               DATE         NULL,
    CONSTRAINT [tmp_ms_xx_constraint_Id_PK1] PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Tbl_Barrower])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Tbl_Barrower] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Tbl_Barrower] ([Id], [Title], [First_Name], [Last_Name], [AddressLine1], [AddressLine2], [City], [StateName], [Country], [PostCode], [Mobile_Number_CountryCode], [Mobile_Number], [Email_Id], [LastUpdated])
        SELECT   [Id],
                 [Title],
                 [First_Name],
                 [Last_Name],
                 [AddressLine1],
                 [AddressLine2],
                 [City],
                 [StateName],
                 [Country],
                 [PostCode],
                 [Mobile_Number_CountryCode],
                 [Mobile_Number],
                 [Email_Id],
                 [LastUpdated]
        FROM     [dbo].[Tbl_Barrower]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Tbl_Barrower] OFF;
    END

DROP TABLE [dbo].[Tbl_Barrower];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Tbl_Barrower]', N'Tbl_Barrower';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_Id_PK1]', N'Id_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_Tbl_Barrower_Tbl_Barrowed_Book]...';


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH NOCHECK
    ADD CONSTRAINT [FK_Tbl_Barrower_Tbl_Barrowed_Book] FOREIGN KEY ([Barrower_id]) REFERENCES [dbo].[Tbl_Barrower] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tbl_Book_Tbl_Barrowed_Book]...';


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH NOCHECK
    ADD CONSTRAINT [FK_Tbl_Book_Tbl_Barrowed_Book] FOREIGN KEY ([ID]) REFERENCES [dbo].[Tbl_Barrower] ([Id]);


GO
PRINT N'Refreshing [dbo].[vw_LibraryTransaction]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[vw_LibraryTransaction]';


GO
PRINT N'Altering [dbo].[spReturnBook]...';


GO
ALTER  procedure spReturnBook
           @id int,
           @barrower_id int,
           @book_id int,
		   @brrowed_Date_time datetime,
		   @return_date date
           
    as
begin
     update  Tbl_Barrowed_Book 
	 set return_date = GETDATE()
	 where (barrower_id=@barrower_id and book_id=@book_id)
	
	insert into Tbl_Barrowed_Book(id,barrower_id,book_id, Barrowed_Date_Time, Return_date)
          values(@id,@barrower_id,@book_id ,@brrowed_Date_time,@return_date)
end
GO
PRINT N'Creating [dbo].[spInsertBarrowedBook]...';


GO

CREATE  procedure [dbo].[spInsertBarrowedBook]
          @id int,
           @barrower_id int,
           @book_id int,
		   @barrowed_Date_time datetime
           
    AS
begin

	insert into spInsertBarrowedBook(id,barrower_id,book_id ,barrowed_Date_time,LastUpdated)
          values(@id,@barrower_id,@book_id ,@barrowed_Date_time,getdate())
end
GO
PRINT N'Refreshing [dbo].[spInsertBarrower]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spInsertBarrower]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH CHECK CHECK CONSTRAINT [FK_Tbl_Barrower_Tbl_Barrowed_Book];

ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH CHECK CHECK CONSTRAINT [FK_Tbl_Book_Tbl_Barrowed_Book];


GO
PRINT N'Update complete.';


GO
