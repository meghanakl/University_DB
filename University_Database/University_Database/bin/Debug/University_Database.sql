﻿/*
Deployment script for University_Database

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "University_Database"
:setvar DefaultFilePrefix "University_Database"
:setvar DefaultDataPath "C:\Users\MeghanaRao\AppData\Local\Microsoft\VisualStudio\SSDT\University_Database"
:setvar DefaultLogPath "C:\Users\MeghanaRao\AppData\Local\Microsoft\VisualStudio\SSDT\University_Database"

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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating [dbo].[Tbl_Barrowed_Book]...';


GO
CREATE TABLE [dbo].[Tbl_Barrowed_Book] (
    [ID]                 INT      NOT NULL,
    [Barrower_id]        INT      NOT NULL,
    [Book_id]            INT      NOT NULL,
    [Barrowed_Date_Time] DATETIME NOT NULL,
    [Return_date]        DATETIME NULL,
    [LastUpdated]        DATETIME NULL,
    CONSTRAINT [pK_Barrowed_Book] PRIMARY KEY CLUSTERED ([Book_id] ASC)
);


GO
PRINT N'Creating [dbo].[Tbl_Barrower]...';


GO
CREATE TABLE [dbo].[Tbl_Barrower] (
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
    CONSTRAINT [Id_PK] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Tbl_Book]...';


GO
CREATE TABLE [dbo].[Tbl_Book] (
    [Title]          VARCHAR (30)    NOT NULL,
    [Author]         VARCHAR (30)    NOT NULL,
    [price]          DECIMAL (10, 2) NOT NULL,
    [Published_Date] DATE            NOT NULL,
    [Purchased_Date] DATE            NOT NULL,
    [Quantity]       DECIMAL (5, 2)  NOT NULL,
    [LastUpdated]    DATE            NULL,
    [ID]             INT             IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);


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
PRINT N'Creating [dbo].[vw_LibraryTransaction]...';


GO
create view vw_LibraryTransaction
as 
select br.ID LibraryId,
br.First_Name + ' ' + br.Last_Name as FullName,
b.title as BookName,
bb.barrowed_date_time as barrowedDate,
bb.Return_date as ReturnDate,
br.Mobile_Number_CountryCode + br.Mobile_Number as ContactNumber 

from Tbl_Barrowed_Book bb
inner join Tbl_Book b on bb.book_id = b.id
inner join Tbl_Barrower br on br.id = bb.Barrower_id
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
     
       
     if not exists(select * from Tbl_Barrowed_Book where (Barrower_id= @barrower_id and Book_id=@book_id))
	insert into tbl_barrowed_Book(id,barrower_id,book_id ,barrowed_Date_time,LastUpdated)
          values(@id,@barrower_id,@book_id ,@barrowed_Date_time,getdate())
end
GO
PRINT N'Creating [dbo].[spInsertBarrower]...';


GO


 CREATE procedure [dbo].[spInsertBarrower]
         
		 @Title varchar(3),
		 @First_Name varchar(30),
           @Last_Name varchar(30),
           @AddressLine1  varchar(30),
           @AddressLine2  varchar(30),
           @City  varchar(30),
           @StateName  varchar(30),
           @Country  varchar(30),
           @PostCode varchar(10),
           @Mobile_Number_CountryCode  varchar(5),
           @Mobile_Number  varchar(10),
           @Email_Id varchar(20),
           @Barrower_Type  varchar(20)
    as
	begin
	if not exists( Select * from tbl_barrower where (Email_Id=@Email_Id) or (Mobile_Number_CountryCode=@Mobile_Number_CountryCode and Mobile_Number=@Mobile_Number))
	begin
	insert into Tbl_Barrower(Title,First_Name,Last_Name,AddressLine1,AddressLine2 , City ,StateName  ,    Country  ,PostCode ,Mobile_Number_CountryCode ,Mobile_Number  ,Email_Id,Barrower_Type,LastUpdated)values(@Title,@First_Name ,
           @Last_Name ,
           @AddressLine1  ,
           @AddressLine2  ,
           @City ,
           @StateName  ,
           @Country  ,
           @PostCode ,
           @Mobile_Number_CountryCode  ,
           @Mobile_Number  ,
           @Email_Id ,
           @Barrower_Type ,
		   getdate())
          
	end
	else 
	begin 
	print ('record already exist please provide another number and number')
	end
	end
GO
PRINT N'Creating [dbo].[spInsertBook]...';


GO



CREATE procedure [dbo].[spInsertBook]
         @title varchar(30),
          @author varchar(30),
           @price decimal(10,2),
           @published_date date,
           @purchased_date date,
           @quantity decimal(5,2)
    as
begin
	if not exists( Select * from Tbl_Book where (title=@title) and (author=@author))
	insert into Tbl_Book(title,author,price,published_date,purchased_date,quantity,LastUpdated)values(@title,@author,@price,@published_date,@purchased_date,@quantity,getdate())
end
GO
PRINT N'Creating [dbo].[spReturnBook]...';


GO
CREATE  procedure spReturnBook
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
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH CHECK CHECK CONSTRAINT [FK_Tbl_Barrower_Tbl_Barrowed_Book];

ALTER TABLE [dbo].[Tbl_Barrowed_Book] WITH CHECK CHECK CONSTRAINT [FK_Tbl_Book_Tbl_Barrowed_Book];


GO
PRINT N'Update complete.';


GO
